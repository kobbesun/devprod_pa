library(shiny)
shinyUI(
        pageWithSidebar(
                # Application title
                headerPanel("Moto MPG Projection as of 1974 in the US"),
                
                sidebarPanel(
                        sliderInput('wt', 'Weight (lb/1000)',value = 2, min = 1.2, 
                                    max = 5.5, step = 0.05),
                        sliderInput('hp', 'Gross horsepower',value = 150, min = 50, 
                                    max = 350, step = 1),
                        #sliderInput('cyl', 'Number of cylinders',value = 6, min = 4, 
                        #            max = 8, step = 2),
                        selectInput('cyl', 'Number of cylinders', c(4, 6, 8), selected = 6)
                        #submitButton('Submit')
                        #actionButton("goButton", "Go!")
                ),
                mainPanel(
                        h4('You entered'),
                        verbatimTextOutput("inputs"),
                        h4('Coefficients of the multiple linear model'),
                        verbatimTextOutput("coefficients"),
                        h4('Which resulted in a prediction of '),
                        verbatimTextOutput("mpg"),
                        h4('1974 motor models with similar MPG (+/-1 mpg) are'),
                        verbatimTextOutput("models"),
                        br(),
                        h4('User Mannual'),
                        div('The shiny app borrowed the multiple regression 
                             model of Coursera course, Regression Models. I built a 
                             multiple regression model based on the data of
                             "Motor Trend Car Road Test" from 1974 Motor Trend US
                             magazine. After data analysis, I chose three independent
                             variables, weight, gross housepower, and number of cylinders,
                             to predict miles/gallon of a motor.'),
                        br(),
                        div('I created three inputs widgets for independent variables
                             in sidebarPanel. The shiny app displays user inputs, model 
                             coefficients, and model prediction result. At last the app 
                             shows the motor models that have mpg within the +/-1 
                             mpg range of predicted mpg. Of course the motor models are
                             from the "Motor Trend Car Road Test" data set.'),
                        br(),
                        div('Github repository: '),
                        div(a('https://github.com/kobbesun/devprod_pa', 
                              href = 'https://github.com/kobbesun/devprod_pa',
                              target = '_blank')),
                        br(),
                        div(' ~ END ~')
                )
        )
)

