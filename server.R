library(shiny)
require(stats)
data(mtcars)

fit.exp <- lm(mpg ~ factor(cyl) + hp + wt, data = mtcars)
similar_models <- function (predict_mpg) {
        similar_ones <- subset(mtcars, mpg > predict_mpg - 1 & mpg < predict_mpg + 1)
        if (nrow(similar_ones) == 0) { 
                "No model with similar MPG found"
        } else {
                similar_ones
        }
}


shinyServer(
        function(input, output) {
                output$inputs <- renderText({ paste('Weight', input$wt, 
                                                    'thousand lb - horsepower', input$hp,
                                                    '- number of cylinder', input$cyl)
                })
                
                output$coefficients <- renderPrint({coefficients(fit.exp)})
                predict_mpg <- reactive({predict(fit.exp, data.frame(cyl = input$cyl,
                                                                     hp = input$hp,
                                                                     wt = input$wt))
                })
                
                output$mpg <- renderText({predict_mpg()})
                
                output$models <- renderPrint({similar_models(predict_mpg())})

        }
)