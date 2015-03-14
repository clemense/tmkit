(in-package :tmsmt)

(smt-plan :operators "/home/ntd/git/tmsmt/pddl/blocksworld/blocks-domain.pddl"
          :facts "/home/ntd/git/tmsmt/pddl/blocksworld/sussman-anomaly.pddl")

(smt-plan :operators "/home/ntd/git/tmsmt/pddl/placement-graph/graph-0.pddl"
          :facts "/home/ntd/git/tmsmt/pddl/placement-graph/scene-transit.pddl")

(with-output-to-file (s "/home/ntd/git/tmsmt/pddl/placement-graph/graph-0.pddl" :if-exists :supersede)
  (pddl-print
   (placement-graph-domain
    (parse-placement-graph "/home/ntd/git/itmp-code/itmp/Non_Reactive/JournalExp/graph.gv")) s))

(with-output-to-file (s "/home/ntd/git/tmsmt/pddl/placement-graph/scene-0.pddl" :if-exists :supersede)
  (pddl-print
   (placement-graph-facts (parse-placement-graph "/home/ntd/git/itmp-code/itmp/Non_Reactive/JournalExp/graph.gv")
                          :object-alist '((Cup1 . S__82) (Cup2 . S__78) (Cup3 . S__70))
                          ;:object-alist '((Cup1 . S__82))
                          :location-alist '((dishwasher S__33 S__34 S__35 S__36 S__37 S__38 S__39 S__40 S__43))
                          :goal-location 'dishwasher)
   s))
