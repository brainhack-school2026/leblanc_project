# leblanc_project

# INSTRUCTIONS 

1. Clone the repository.
2. Open the project in R.
3. Run:

   install.packages("renv")   # if needed
   renv::restore()

4. Run:

   make

## short bio for the Git module exercices

I am a Ph. D. student in neuropsychology. I will be working on IRMs data to analyze the effects of oral contraceptives on brain development during adolescence. 

<a href="https://github.com/roxanneleblanc23">
  <img src="https://avatars.githubusercontent.com/u/284058183?v=4" width="100px;" alt=""/>
  <br /><sub><b>Roxanne Leblanc</b></sub>
</a>

# Project presentation
## Introduction 
This project aims to investigate the effects of oral contraceptives initiation on brain development during adolescence. For an animated overview of the litterature on this subject, please follow this link : https://docs.google.com/presentation/d/18sPFdWEy6WP5lSThgEJ0WI-9j097xqXL/edit?usp=sharing&ouid=107748738109768169913&rtpof=true&sd=true 
## Objectives

1. To model longitudinal changes in cortical thickness and grey matter volume across adolescence in relation to hormonal group.

2. To identify and visualize cortical regions showing differential developmental trajectories between hormonal groups using brain surface maps.

## Data
### Sample
 
My sample contains around 12 000 participants divised in the following groups : around 400 OC users, 5000 females non-users and 5000 males. 
They provided sMRI scans at 4 times : 9-10 y/o, 11-12 y/o, 13-14 y/o, and 15-16 y/o.

### Material
T1 sMRI scans, already pre-processed and segmented using Desikan-Killiany and Destrieux atlas
Cortical thickness, cortical and subcortical volumes

Sex at birth at T1, and OC use at each time.

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

I will then use the **contrast** function.

This function will allow be to test specific comparisons between estimated marginal means previously calculated with emmeans. 

### Vizualisation

The second step of this project will be to visualize the model results on brain maps. I will map the group differences in developmental trajectories by visualizing the estimates (beta) of the time × hormonal group interaction from linear mixed-effects models. 
I will generate a total of 6 brain maps: 3 for each brain phenotype (cortical thickness and volume).
Because there are three groups, each map corresponds to a specific pairwise group comparison (using the reference group), and displays the time × group interaction effects, reflecting differences in developmental trajectories between the two groups being compared.
I plan on coloring the map using the same logic as these authors : https://onlinelibrary.wiley.com/doi/epdf/10.1002/hbm.23154  

#### ggseg R package

I will be using the ggseg package, in order to visualize the interaction effects for each ROI of the brain. chrome-extension://efaidnbmnnnibpcajpcglclefindmkaj/https://cran.r-project.org/web/packages/ggseg/ggseg.pdf
To do so, the beta of the interaction effects of all the roi models be in a dataframe with 2 columns : roi, and value. There will be a dataframe for each gray matter phenotype, and for each pair of group comparison. It will also be important to name the roi the same way as they are names in the atlas I will be using. 
I will use the following arguments :

ggseg(atlas = "nom_atlas", data = dataframe_betas,
      mapping = aes(fill = nom_colonne_beta)) +
  scale_fill_gradient2(low="blue", mid="white", high="red", midpoint=0)
 
Le code de couleur de cette visualisation sera le suivant : bleu pour betas négatifs, blanc pour betas près de 0, rouge pour betas post. The color code will be the following : blue for negative betas, white for betas eith values around 0, red for positive betas. 
## Deliverables
May 28th : finish data cleaning and structure data for analyses
June 3rd : finish analyses
June 5th : finish visualizations


## Medium 

The results of the analyses and the graphs will be presented in this repo. I will also provide the code, but I will not share the data since it needs a Data Use Certification. 
