## Welcome to Machine Learning Goodreads Project
In this project we will analyse the Goodreads-books dataset from the Kaggle website. 

### Table of Contents

1. [Installation](#installation)
2. [Methodology](#methodology)
3. [Queries](#Questions)
6. [Summary Results](#results)

## Installation <a name="installation"></a>

The python notebook files in this repo should run with Anaconda distribution of Python versions 3.*.

You can extract the files to a folder.

books.csv :  It’s the dataset that will be used for this project.

GoodReads ML Project Report.docx : The project report.

Project_Description_ML_DA_2022.pdf : It’s the description and requirements of the project

ProjectGoodReads.ipynb : It’s the entire code of the project in Jupyter Notebook. It’s highly recommended to run it with Anaconda distribution of Python versions 3.

You can either upload the files using Jupyter notebook or place these files in the current working directory and then run the notebooks with a Python interpreter.

## Methodology<a name="methodology"></a>

In this machine learning project, I will try to follow exactly the methodology below.

Data preparation :  It’s the stage at which the dataset will be analyzed and I’ll try to understand it. It’s necessary to arouse my curiosity and ask intelligent questions for queries. This step will compose most of the work, because after analyzing them, I will apply transformations to prepare them for model training.

Model training : in this step, I will import several machine learning models from the scikit learn library. I will use part of the dataset to train these models to fit them.

Model optimization : This step and the one below work together. Because the model evaluation is the main indication that the model is not optimized. Numerous tests and parameter changes were made to improve the model. 

Model evaluation : The evaluation is super important to say if all the dataset preparation and the chosen models were appropriate. If the result of the evaluation is bad, we will go back to previous steps.

Model maintenance : It’s the debug step.

Deployment : After the entire process that is carried out in a development environment, this project will be put into production.


## Queries :thinking: <a name="Questions"></a>

To get more insights about the Goodreads-books dataset, I wanted to find answers to the following questions: 

1. There is any kind of correlation between the columns ?

2. How the target column is distributed ?

3. What are the top 10 best rated books ?

4. What are the top 10 best rated books with a higher total ratings count than the average ?

5. What are the 10 authors who have more books with average_rate and ratings_count longer than average ?
			   
6. What is the top 10 most rated books ?

7. What is the top 10 authors who own more books ?

8. What is the top 10 longest books ?   

9. What is the top 15 publishers by number of publications ?

10. What is the bottom 5 poorly rated authors (average_rate < 3) ?

11. Did the books with more text reviews receive higher ratings ?

12. Did the books with more reviews receive higher ratings ?
			   
## Summary Results<a name="results"></a>

We can observe that the results were quite similar. The best model is the Random Forest model for presenting the lowest values. The fit took a little while to execute, a sign that there is still a lot of optimization work to be done. The data processing, the choice and parameters of the model directly influence this value.

We can conclude with this exercise how powerful machine learning algorithms can be. No wonder that many companies work very hard to master them. Prediction is something that can be very valuable financially. Many skills must be honed to reach a very high level as a professional in this area, such as statistical analysis, notions of probability, computing, and mathematics. The models are complex, and a thorough study must be done to understand their parameters and their influence on the outcome.


