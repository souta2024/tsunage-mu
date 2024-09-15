// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
// cssファイルの適用
import "../stylesheets/application.scss";
import "../stylesheets/shared/main.css";
import "../stylesheets/views/header.css";
// jsファイルの適用
import "../views/script.js";
import "../views/header.js";

Rails.start()
Turbolinks.start()
ActiveStorage.start()
