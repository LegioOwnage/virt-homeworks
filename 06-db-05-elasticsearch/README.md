# Домашнее задание к занятию "6.5. Elasticsearch"

## Задача 1

В этом задании вы потренируетесь в:
- установке elasticsearch
- первоначальном конфигурировании elastcisearch
- запуске elasticsearch в docker

Используя докер образ [centos:7](https://hub.docker.com/_/centos) как базовый и 
[документацию по установке и запуску Elastcisearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html):

- составьте Dockerfile-манифест для elasticsearch
- соберите docker-образ и сделайте `push` в ваш docker.io репозиторий
- запустите контейнер из получившегося образа и выполните запрос пути `/` c хост-машины

Требования к `elasticsearch.yml`:
- данные `path` должны сохраняться в `/var/lib`
- имя ноды должно быть `netology_test`

В ответе приведите:
- текст Dockerfile манифеста
- ссылку на образ в репозитории dockerhub
- ответ `elasticsearch` на запрос пути `/` в json виде

Подсказки:
- возможно вам понадобится установка пакета perl-Digest-SHA для корректной работы пакета shasum
- при сетевых проблемах внимательно изучите кластерные и сетевые настройки в elasticsearch.yml
- при некоторых проблемах вам поможет docker директива ulimit
- elasticsearch в логах обычно описывает проблему и пути ее решения

Далее мы будем работать с данным экземпляром elasticsearch.

Ответ: 

- текст Dockerfile манифеста:
```bash
FROM centos:7

RUN rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
RUN echo "[elasticsearch]" >>/etc/yum.repos.d/elasticsearch.repo &&\
    echo "name=Elasticsearch repository for 8.x packages" >>/etc/yum.repos.d/elasticsearch.repo &&\
    echo "baseurl=https://artifacts.elastic.co/packages/8.x/yum" >>/etc/yum.repos.d/elasticsearch.repo &&\
    echo "gpgcheck=1" >>/etc/yum.repos.d/elasticsearch.repo &&\
    echo "gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch" >>/etc/yum.repos.d/elasticsearch.repo &&\
    echo "enabled=0" >>/etc/yum.repos.d/elasticsearch.repo &&\
    echo "autorefresh=1" >>/etc/yum.repos.d/elasticsearch.repo &&\
    echo "type=rpm-md" >>/etc/yum.repos.d/elasticsearch.repo

RUN yum install -y --enablerepo=elasticsearch elasticsearch

ADD elasticsearch.yml /etc/elasticsearch/

RUN chown -R root:elasticsearch /etc/elasticsearch/

USER elasticsearch

ENV PATH=$PATH:/usr/share/elasticsearch/bin

CMD ["elasticsearch"]

EXPOSE 9200 9300
```
- ссылку на образ в репозитории dockerhub: https://hub.docker.com/r/legioownage/elasticsearch_netology

- ответ `elasticsearch` на запрос пути `/` в json виде:
```bash
curl -u elastic:elastic 127.0.0.1:9200
{
  "name" : "netology_test",
  "cluster_name" : "netology_cluster",
  "cluster_uuid" : "XeZuwkNIRte4ieckPVyERA",
  "version" : {
    "number" : "8.1.0",
    "build_flavor" : "default",
    "build_type" : "rpm",
    "build_hash" : "3700f7679f7d95e36da0b43762189bab189bc53a",
    "build_date" : "2022-03-03T14:20:00.690422633Z",
    "build_snapshot" : false,
    "lucene_version" : "9.0.0",
    "minimum_wire_compatibility_version" : "7.17.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "You Know, for Search"
}
```

## Задача 2

В этом задании вы научитесь:
- создавать и удалять индексы
- изучать состояние кластера
- обосновывать причину деградации доступности данных

Ознакомтесь с [документацией](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html) 
и добавьте в `elasticsearch` 3 индекса, в соответствии со таблицей:

| Имя | Количество реплик | Количество шард |
|-----|-------------------|-----------------|
| ind-1| 0 | 1 |
| ind-2 | 1 | 2 |
| ind-3 | 2 | 4 |

Получите список индексов и их статусов, используя API и **приведите в ответе** на задание.

Получите состояние кластера `elasticsearch`, используя API.

Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?

Удалите все индексы.

**Важно**

При проектировании кластера elasticsearch нужно корректно рассчитывать количество реплик и шард,
иначе возможна потеря данных индексов, вплоть до полной, при деградации системы.

Ответ:
```json
curl -X PUT http://127.0.0.1:9200/ind-1 -H 'Content-Type: application/json' -d '{"settings": {"number_of_shards": 1, "number_of_replicas": 0}}'
{"acknowledged":true,"shards_acknowledged":true,"index":"ind-1"}
curl -X PUT http://127.0.0.1:9200/ind-2 -H 'Content-Type: application/json' -d '{"settings": {"number_of_shards": 2, "number_of_replicas": 1}}'
{"acknowledged":true,"shards_acknowledged":true,"index":"ind-2"}
curl -X PUT http://127.0.0.1:9200/ind-3 -H 'Content-Type: application/json' -d '{"settings": {"number_of_shards": 4, "number_of_replicas": 2}}'
{"acknowledged":true,"shards_acknowledged":true,"index":"ind-3"}
curl -X GET 'http://127.0.0.1:9200/_cat/indices?v'
health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   ind-1 ef2m-SKIS6O35NF0nSu1zQ   1   0          0            0       225b           225b
yellow open   ind-3 8S2auZXvQxWIgib8eFTpWA   4   2          0            0       900b           900b
yellow open   ind-2 apG5w2hLS8CYW2LX8y7HHg   2   1          0            0       450b           450b
curl -X GET 'http://127.0.0.1:9200/_cluster/health'
{"cluster_name":"netology_cluster","status":"yellow","timed_out":false,"number_of_nodes":1,"number_of_data_nodes":1,"active_primary_shards":8,"active_shards":8,"relocating_shards":0,"initializing_shards":0,"unassigned_shards":10,"delayed_unassigned_shards":0,"number_of_pending_tasks":0,"number_of_in_flight_fetch":0,"task_max_waiting_in_queue_millis":0,"active_shards_percent_as_number":44.44444444444444}
```
Часть индексов находится в состоянии yellow, потому что мы не можем делать реплики на одном узле. Реплика это по сути резервная копия, которая должна хранится на другом узле.
```json
curl -X DELETE 'http://127.0.0.1:9200/ind-1'
{"acknowledged":true}
curl -X DELETE 'http://127.0.0.1:9200/ind-2'
{"acknowledged":true}
curl -X DELETE 'http://127.0.0.1:9200/ind-3'
{"acknowledged":true}
```


## Задача 3

В данном задании вы научитесь:
- создавать бэкапы данных
- восстанавливать индексы из бэкапов

Создайте директорию `{путь до корневой директории с elasticsearch в образе}/snapshots`.

Используя API [зарегистрируйте](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html#snapshots-register-repository) 
данную директорию как `snapshot repository` c именем `netology_backup`.

**Приведите в ответе** запрос API и результат вызова API для создания репозитория.

Создайте индекс `test` с 0 реплик и 1 шардом и **приведите в ответе** список индексов.

[Создайте `snapshot`](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html) 
состояния кластера `elasticsearch`.

**Приведите в ответе** список файлов в директории со `snapshot`ами.

Удалите индекс `test` и создайте индекс `test-2`. **Приведите в ответе** список индексов.

[Восстановите](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html) состояние
кластера `elasticsearch` из `snapshot`, созданного ранее. 

**Приведите в ответе** запрос к API восстановления и итоговый список индексов.

Подсказки:
- возможно вам понадобится доработать `elasticsearch.yml` в части директивы `path.repo` и перезапустить `elasticsearch`

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
