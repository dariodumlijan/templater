# README

### The lib used: [DOMPDF](https://github.com/dompdf/dompdf/)

**The main files:**
-  The controller: [templates_controller.rb](https://github.com/dariodumlijan/templater/blob/main/app/controllers/templates_controller.rb)
-  The view: [index.html.erb](https://github.com/dariodumlijan/templater/blob/main/app/views/templates/index.html.erb)
- The PHP exec script: [main.php](https://github.com/dariodumlijan/templater/blob/main/lib/php/main.php)

**There is a:**
- BetterDoc version of the PDF
  - `GET`/`POST` = `localhost:3000/betterdoc`
  - The view: [betterdoc.html.erb](https://github.com/dariodumlijan/templater/blob/main/app/views/templates/betterdoc.html.erb)
- My attempt to copy the same PDF with custom HTML & CSS
  - `GET`/`POST` = `localhost:3000/`
  - The view: [index.html.erb](https://github.com/dariodumlijan/templater/blob/main/app/views/templates/index.html.erb)


### How to run
```sh
# Install ruby gems
bundle install

# Run the application
rails server
```