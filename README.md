# This is the official implementation of the paper:
# 2S: Enabling Uncertainty Quantification in Federated Learning Clients in NeurIPS BDU Workshop 2024. 

Federated Learning (FL) is a paradigm where multiple clients collaboratively train models while keeping their data decentralized. 
Despite advancements in FL, uncertainty quantification (UQ) on the client side remains unexplored. Existing methods incorporating Bayesian approaches in FL are often resource-intensive and do not directly address client-side UQ. In this paper, we propose the 2S (Two Students) approach to address this gap. Our approach distills a Bayesian model ensemble (BME) into two student models: one focused on accurate predictions and the other on uncertainty quantification. The 2S approach also includes a novel truncation filter that uses credible intervals to selectively aggregate client models, mitigating the impact of non-i.i.d. data. Through empirical validation on a regression task, we demonstrate that the 2S approach enables effective and scalable UQ on the client side, providing robust and reliable updates across decentralized data sources. 



![Feature Demonstration](https://github.com/cristovaoiglesias/2S/blob/main/exp_with_truncation_full.gif)

[GIF](https://github.com/cristovaoiglesias/2S/blob/main/exp_with_truncation_full.gif)

Figure 1. 2S approach (**with truncation filter**) applied to the regression problem of paper.


![Feature Demonstration](https://github.com/cristovaoiglesias/2S/blob/main/exp_without_truncation_full.gif)

[GIF](https://github.com/cristovaoiglesias/2S/blob/main/exp_without_truncation_full.gif)


Figure 2. 2S approach (**without truncation filter**) applied to the regression problem of paper.





## To reproduce the experiments, execute the codes below: 

### Initial Ensemble 

[Code](
https://github.com/cristovaoiglesias/2S/blob/main/InitialEnsemble.jl)


### To run experiments with 2S with truncation filter, use the code of [folder](
https://github.com/cristovaoiglesias/2S/tree/main/exp_with_truncation)

### To run experiments with 2S without truncation filter, use the code of [folder](
https://github.com/cristovaoiglesias/2S/tree/main/exp_without_truncation)

### To run experiments with FedAvg, use the code of [folder](https://github.com/cristovaoiglesias/2S/tree/main/baseline_fedAavg)

### To execute code related to the experiment with GP, run the following file:

```
julia exp_GP.jl
```

### To reproduce the figures and table presented in the paper, run the following file:

```
julia plots_analysis.jl
```


