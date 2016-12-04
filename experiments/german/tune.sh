
# ID=`./gpu_lock.py --id-to-hog 0`
ID=3
echo $ID
if [ $ID -eq -1 ]; then
    echo "this gpu is not free"
    exit
fi
# ./gpu_lock.py

# codedir=/afs/inf.ed.ac.uk/group/project/img2txt/dep_parser/select_net_multi_ling_v1.3.10
codedir=/afs/inf.ed.ac.uk/group/project/img2txt/dep_parser/dense_release

curdir=`pwd`
lr=0.001
label=.tune
model=$curdir/model_$lr$label.t7
log=$curdir/log_$lr$label.txt

# load=/disk/scratch/XingxingZhang/dep_parse/experiments/german/unlabeled/model_0.001.std.ft0.dp0.4.r0.1.bs20.t7
load=/disk/scratch/s1270921/dep_parse/experiments/German/model_0.001.std.ft0.dp0.4.r0.1.bs20.t7


cd $codedir

CUDA_VISIBLE_DEVICES=$ID th post_train.lua \
    --load $load \
    --save $model \
    --lr $lr \
    --maxEpoch 10 \
    --optimMethod SGD \
    | tee $log

cd $curdir

# ./gpu_lock.py --free $ID
# ./gpu_lock.py

