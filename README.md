# This is the official implementation of the paper "2S: Enabling Uncertainty Quantification in Federated Learning Clients" in NeurIPS BDU Workshop 2024. 

Federated Learning (FL) is a paradigm where multiple clients collaboratively train models while keeping their data decentralized. 
Despite advancements in FL, uncertainty quantification (UQ) on the client side remains unexplored. Existing methods incorporating Bayesian approaches in FL are often resource-intensive and do not directly address client-side UQ. In this paper, we propose the 2S (Two Students) approach to address this gap. Our approach distills a Bayesian model ensemble (BME) into two student models: one focused on accurate predictions and the other on uncertainty quantification. The 2S approach also includes a novel truncation filter that uses credible intervals to selectively aggregate client models, mitigating the impact of non-i.i.d. data. Through empirical validation on a regression task, we demonstrate that the 2S approach enables effective and scalable UQ on the client side, providing robust and reliable updates across decentralized data sources. 


## To reproduce the experiments, execute the code related to tasks 1 and 2. 

### Datasets 

[Dataset for task 1](https://github.com/cristovaoiglesias/SBM/blob/main/empirical_tests/task1/dataset_task1.jl 'Dataset for task 1')

[Dataset for task 2](https://github.com/cristovaoiglesias/SBM/blob/main/empirical_tests/task2/dataset_task2.jl 'Dataset for task 2')


### To execute the code related to the steps of task 1, run the following files:

#### run the code of [step1 folder](https://github.com/cristovaoiglesias/SBM/tree/main/empirical_tests/task1/step1)

```
julia SBM_for_bbf1_bbf2.jl

julia BBF1_optimization_with_particleSwarm.jl

julia BBF2_optimization_with_particleSwarm.jl
```

#### run the code of [step2 folder](https://github.com/cristovaoiglesias/SBM/tree/main/empirical_tests/task1/step2)

```
julia surrogate_data_plot.jl
```


#### run the code of [step3 folder](https://github.com/cristovaoiglesias/SBM/tree/main/empirical_tests/task1/step3)

```
julia SBM-BBF1-NSD.jl

julia SBM-BBF2-NSD.jl
```

#### run the code of [step4 folder](https://github.com/cristovaoiglesias/SBM/tree/main/empirical_tests/task1/step4)

```
julia SBM-BBF1-WSD.jl

julia SBM-BBF2-WSD.jl
```


#### run the code of [step5 folder](https://github.com/cristovaoiglesias/SBM/tree/main/empirical_tests/task1/step5)

```
julia CBM.jl
```


### To execute code related to the steps of task 2, run the following file:

```
julia SBM_building_BNN.jl
```


### To reproduce the figures and table presented in the paper, run the following files:

All the codes files below are in the [result_analysis folder](https://github.com/cristovaoiglesias/SBM/tree/main/empirical_tests/results_analysis)

```
julia mean_execution_time_table.jl

julia plot_figure3.jl

julia plot_figures_2_4_5.jl

julia plot_figures_6_S1.jl
```


