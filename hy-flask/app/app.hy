#!/usr/bin/env hy
(import [flask [Flask]])
(setv app (Flask "__main__"))

(with-decorator (app.route "/hello-world")
    (defn hello-world []
        "Hello, world!"))

;; Return given ID, only accepts integers
(with-decorator (app.route "/post/<int:post_id>")
  (defn show_post [post_id]
    f"POST {post-id}"))

;; Return given subpath
(with-decorator ((. app route) "/path/<path:subpath>")
  (defn show_subpath [subpath]
    f"SUBPATH {subpath}"))


;; ------ redirection example -------
(with-decorator (.route app "/projects/")
  ;; if you make get-request to "{url}/projects",
  ;; flask will redirect you automagicly to the cannonical "{url}/projects/"
  (defn projects []
    "The ptoject page"))

(setv route (. app route))
(with-decorator (route "/about")
  ;; if you make get-request to "{url}/about/",
  ;; flask will send 404 error"
  (defn about []
    "About page"))
;;------------------------------------

(.run app)
