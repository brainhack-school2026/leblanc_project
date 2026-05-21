# leblanc_project

## short bio for the Git module exercices

I am a Ph. D. student in neuropsychology. I will be working on IRMs data to analyze the effects of oral contraceptives on brain development during adolescence. 

<a href="https://github.com/roxanneleblanc23">
  <img src="https://avatars.githubusercontent.com/u/284058183?v=4" width="100px;" alt=""/>
  <br /><sub><b>Roxanne Leblanc</b></sub>
</a>

# Project presentation
## Introduction 
This project aims to investigate the effects of oral contraceptives initiation on brain development during adolescence. For an animated overview of the litterature on this subject, please follow this link :  
## Objective
## Data
## Tools
### Analyses

We will conduct separate linear mixed-effects models to model brain development across time for each gray matter phenotype in every region of interest (ROI), including cortical thickness and volume. The models will include the following variables :

Independant variables : hormonal group (masculine, feminine non OC user, feminine OC user), time (1, 2, 3, 4)
Dependant variables : cortical thickness/volume

Control variables : hemisphere (r/l), total intracranial volume, site, IRM model)
Random effect : per ID

To do so, I will use the following tools :

#### lme4 R package
I will use the **lmer** function (chrome-extension://efaidnbmnnnibpcajpcglclefindmkaj/https://cran.r-project.org/web/packages/lme4/lme4.pdf)

This function will allow me to modelize linear mixed models. My arguments will be the following : 

model_cortical_thickness_or_volume <- lmer(
  thickness/volume ~ time * hormonal_group +
              hemisphere +
              site +
              scanner +
              (1 | subject_id),  data = data

The ouputs will be the estimate (beta), the standard error, the t-value avec the p-value of every principal and interaction effect. Multiple comparisons will be controlled using the False Discovery Rate (FDR) correction, applied separately for each gray matter phenotype.
#### emmeans R package
I will first use the emmeans function (chrome-extension://efaidnbmnnnibpcajpcglclefindmkaj/https://cran.r-project.org/web/packages/emmeans/emmeans.pdf)

This function will allow me to estimate marginal means for factors in my model. The models for which the interaction between hormonal group and time is still statistically significant after FDR correction will me estimated. My arguments will be the following :

model_emmeans<- emmeans(model, ~ time *  hormonal_group)

I will then use the **contrast** function
### Vizualisation
## Deliverables
## Medium 

