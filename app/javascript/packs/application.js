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
import "../stylesheets/shared/main-content.css";
import "../stylesheets/views/header.css";
import "../stylesheets/views/post.css";
import "../stylesheets/views/post_show.css";
import "../stylesheets/views/favorite.css";
import "../stylesheets/views/user.css";
import "../stylesheets/views/draft.css";
// jsファイルの適用
import "../views/script.js";
import "../views/header.js";
import "../views/users.js";
import "../views/posts.js";

Rails.start()
Turbolinks.start()
ActiveStorage.start()
