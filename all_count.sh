#!/bin/bash
CURDIR=$(cd `dirname $0`; pwd)
cd $CURDIR

ls $CURDIR/csv_files/*.csv | while read file; do
  cnt=$(cat $file | wc -l)
  table=`basename $file`
  table=${table%.*}
  in_db_cnt=$(mysql -h 127.0.0.1 -P 4000 -u root -e "use imdbload; select count(*) from $table;" | sed -sn 2p)
  if [ $cnt -ne $in_db_cnt ]
  then
    echo $table $cnt $in_db_cnt $(($cnt-$in_db_cnt))
  fi
done
