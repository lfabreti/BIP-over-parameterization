#!/bin/bash

NUM_BURNIN_ITER=15000
NUM_MCMC_ITER=100000
NUM_CORES=2
NUM_DATASETS=100
NUM_TAXA="16 64"
NUM_SITES="100 1000"
BL_MEAN="0.1 0.02"
MODEL="JC GTR_G_I_Beast GTR_G_I_MrBayes GTR_G_I_RevBayes GTR_G_I_Tame"


SCRIPTS_DIR="scripts_tmp"
SCREEN_DIR="screen_log"
CONVERGENCE_DIR="convergence_assessment"


if [ -d ${SCRIPTS_DIR} ]; then
    rm -rf ${SCRIPTS_DIR}
fi
mkdir ${SCRIPTS_DIR}

if [ -d ${SCREEN_DIR} ]; then
    rm -rf ${SCREEN_DIR}
fi
mkdir ${SCREEN_DIR}

if [ -d ${CONVERGENCE_DIR} ]; then
    rm -rf ${CONVERGENCE_DIR}
fi
mkdir ${CONVERGENCE_DIR}




for i in `seq 1 $NUM_DATASETS`;
do

    bash_script_name="${SCRIPTS_DIR}/analysis_sim_${i}.sh"

    for j in ${NUM_TAXA[@]};
    do

        for k in ${NUM_SITES[@]};
        do

            for z in ${BL_MEAN[@]};
            do

                for m in ${MODEL[@]};
            	do

                     if [ ! -f results_sim_clades_PP/${m}_nTaxa_${j}_nSites_${k}_bl_${z}_sim_${i}.txt ]; then
                         echo "echo \"NUM_TAXA=${j}; NUM_SITES=${k}; BL_MEAN=${z}; SIM=${i}; SUBST_MODEL=\\\"${m}\\\"; NUM_BURNIN_ITERATIONS=${NUM_BURNIN_ITER}; NUM_MCMC_ITERATIONS=${NUM_MCMC_ITER}; source(\\\"scripts/mcmc_simulation.Rev\\\");\" | rb > ${SCREEN_DIR}/rb_${m}_nTaxa_${j}_nSites_${k}_bl_${z}_sim_${i}.out" >> ${bash_script_name}
                         echo "Rscript scripts/convergence_check.R ${j} ${k} ${z} ${i} ${m}" >> ${bash_script_name}
                         echo "echo \"NUM_TAXA=${j}; NUM_SITES=${k}; BL_MEAN=${z}; SIM=${i}; SUBST_MODEL=\\\"${m}\\\"; source(\\\"scripts/postprocessing.Rev\\\");\" | rb  > ${SCREEN_DIR}/rb_${m}_nTaxa_${j}_nSites_${k}_bl_${z}_sim_${i}.out" >> ${bash_script_name}
                     fi

                done

            done

        done

    done

    chmod +x ${bash_script_name}

done


parallel -j ${NUM_CORES} ::: bash ${SCRIPTS_DIR}/*.sh

