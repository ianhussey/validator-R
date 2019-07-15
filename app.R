# Minimal demo of mapping file and folder structure without uploading files
# only works locally, not as a web hosted shiny app.
# author: Ian Hussey (ian.hussey@ugent.be)

# dependencies
library(shiny)
library(shinyFiles)

# ui
ui <- fluidPage(
  shinyDirButton("button_get_folder", 
                 "Choose a folder" ,
                 title = "Please select a folder:",
                 buttonType = "default", 
                 class = NULL),
  
  textOutput("txt_file")
)

# server
server <- function(input, 
                   output,
                   session){
  
  volumes = getVolumes()
  
  observe({
    
    shinyDirChoose(input, 
                   "button_get_folder", 
                   roots = volumes, 
                   session = session)
    
    if(!is.null(input$button_get_folder)){
      
      # browser()
      input_directory <- parseDirPath(volumes, 
                                      input$button_get_folder)
      list_bands      <- list.files(input_directory, 
                                    full.names = FALSE,
                                    recursive = TRUE)
      output$txt_file <- renderText(list_bands)
      
    }
    
  })
}

# run app
shinyApp(ui = ui, 
         server = server)


