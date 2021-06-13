(import [flask [Flask request]])
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
  (defn about []
    "About page"))
;;------------------------------------

;; ------- HTTP methods example --------
;; Only POST and GET verbs will be accepted
;; OBS: (fn arg1 :arg2 [str str]) direcly translates to:
;; fn(arg1, arg2=[str,str])
(with-decorator (route "/login"
                       :methods ["GET" "POST"])
  (defn login []
    (if (= "POST" (. request method))
      "POST RECIVED, CALL LOGIN ROUTINE"
      "GET RECIVED, CALL GETTING PAGE")))
;;------------------------------------

(.run app)
