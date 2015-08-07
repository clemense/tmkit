(require :tmsmt)
(in-package :tmsmt)

(defparameter *baxter-source-directory*
  (concatenate 'string
               (namestring (asdf:system-source-directory :robray))
               "/demo/baxter/"))
(uiop/stream:copy-file (robray::output-file "baxter.inc" *baxter-source-directory*)
                       (robray::output-file "baxter.inc" robray::*robray-tmp-directory*))

(defparameter *scene-directory*
  (rope *tmsmt-root* "/scene/"))

(moveit-init (robray::urdf-resolve-file "package://baxter_description/urdf/baxter.urdf"))

(defparameter *group* "right_arm")
(defparameter *link* (container-group-endlink *moveit-container* *group*))
(defparameter *q-all-start* (amino:make-vec (container-variable-count *moveit-container*)))

(context-remove-object *plan-context* "block_a")

(context-remove-object *plan-context* "block_b")

(context-remove-all-objects *plan-context*)

(container-set-group *moveit-container* *group*)

(defparameter *object-graph*
  (load-scene-file (rope *scene-directory* "scene.robray")))

(defparameter *object-goal*
  (load-scene-file (rope *scene-directory* "goal1.robray")))

(defparameter *tf-grasp-rel* (tf* (y-angle (* 1 pi)) (vec3* .00 .00 .10)))

(defvar *plan*)

(time
 (progn
   (setq *plan*
         (itmp-rec *object-graph* *object-goal*
                   (rope *tmsmt-root* "pddl/itmp/itmp-blocks-linear.pddl")
                   :encoding :linear
                   :max-steps 3 :resolution .2))
   nil))

;; (render-group-itmp *plan-context* *group*
;;                      *plan*
;;                      :render-options  (render-options-default :use-collision nil
;;                                                               :options (render-options-fast))
;;                      :scene-graph (scene-graph (plan-context-robot-graph *plan-context*)
;;                                                *object-graph*)
;;                      :frame-name "right_endpoint")


;; (context-apply-scene *plan-context* *object-graph*)
;; (render-group-config *plan-context* *group*
;;                      ;(container-plan-endpoint (third *plan*))
;;                      *q-all-start*
;;                      :options (render-options-medium))
