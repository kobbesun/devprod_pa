---
title       : Moto MPG Projection as of 1974 in the US
subtitle    : Developing Data Produts Peer Assignment
author      : ksun
job         : 
framework   : deckjs        # {io2012, html5slides, shower, dzslides, ...}
deckjs:
        theme: web-2.0
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
--- 

## Moto MPG Projection as of 1974 in the US
<h3>Developing Data Produts Peer Assignment</h3>
<div>KSUN</div>

--- 

## Idea and Features


<div style = "float:left; width:580px; text-align:justify; font-size: 18px">
        <ul>- The shiny app utilized the data of "Motor Trend Car Road Test" from 
        1974 Motor Trend US magazine</ul>
        <ul>- Prediciton Model: Multiple Linear Regression Model</ul>
        <ul>Three independent variables: weight, gross housepower, and number of cylinders</ul>
        <ul>- One dependent variable: MPG - miles/gallon of a motor.</ul>
        <ul>- The app also suggests motor models with MPG close to the predected MPG</ul>


</div>
<div style = "float:right;">
        <img src = "./assets/img/motor_trend.jpg" style="height:480px; width:363px">
</div>


--- 

## The Shiny App
<div style="font-size:18px;"> It will take a fews seconds to load the app...</div>
<div>
<iframe src = "https://kobbesun.shinyapps.io/devprod_pa/" width="1000px" height="500px" ></iframe>
</div>

---

## Prediction Model

```r
require(stats)
data(mtcars)

fit.exp <- lm(mpg ~ factor(cyl) + hp + wt, data = mtcars)
summary(fit.exp)
```

```
## 
## Call:
## lm(formula = mpg ~ factor(cyl) + hp + wt, data = mtcars)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -4.2612 -1.0320 -0.3210  0.9281  5.3947 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  35.84600    2.04102  17.563 2.67e-16 ***
## factor(cyl)6 -3.35902    1.40167  -2.396 0.023747 *  
## factor(cyl)8 -3.18588    2.17048  -1.468 0.153705    
## hp           -0.02312    0.01195  -1.934 0.063613 .  
## wt           -3.18140    0.71960  -4.421 0.000144 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2.44 on 27 degrees of freedom
## Multiple R-squared:  0.8572,	Adjusted R-squared:  0.8361 
## F-statistic: 40.53 on 4 and 27 DF,  p-value: 4.869e-11
```

---

## Implementation
<div style="font-size:22px;"> The Server.R logic predicts MPG given user inputs. Function similar_models finds motor models with MPG close to predicted MPG.
 <a href="https://github.com/kobbesun/devprod_pa"> Link to github repository</a></div>


```r
#Sever.R
similar_models <- function (predict_mpg) {
        similar_ones <- subset(mtcars, mpg > predict_mpg - 1 & mpg < predict_mpg + 1)
        if (nrow(similar_ones) == 0) { 
                "No model with similar MPG found"
        } else { similar_ones}
}

shinyServer(
        function(input, output) {        
                output$coefficients <- renderPrint({coefficients(fit.exp)})
                predict_mpg <- reactive({predict(fit.exp, data.frame(cyl = input$cyl, hp = input$hp, wt = input$wt))})
                output$mpg <- renderText({predict_mpg()})
                output$models <- renderPrint({similar_models(predict_mpg())})}
)
```




