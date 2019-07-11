#!/usr/bin/env roseus

(load "package://eus_vive/euslisp/lib/baxter-vive-interface.l")


(defun init ()
  (ros::roseus "baxtereus_vive")
  (baxter-vive-init)
  (send *ri* :angle-vector-raw (send *baxter* :reset-pose) 5000)
  (send *ri* :stop-grasp :arms :wait nil)
  (send *ri* :wait-interpolation)
  (send *ti* :send-joy-feedback :larm)
  (send *ti* :send-joy-feedback :rarm))


(defun main (&key (head nil) (visualize t))
  (init)
  (send *ti* :calib-vive :rarm)
  (send *ti* :main-loop :head head :visualize visualize))