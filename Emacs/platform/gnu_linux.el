;; ----------------------------------------------------------------------
;; StarRC projects
;; ----------------------------------------------------------------------
(setq my-starrc-src-root "/remote/dept5242v/users/yenliang/src/")
(ede-cpp-root-project "starrc-bug"
                      :file (concat my-starrc-src-root "head.bug/" "Master.hier")
                      :include-path '( "/libSim"
                                       "/xin"
                                       "/dir"
                                       "/dbXtract"
                                       )
                      :system-include-path '( "/usr/include" ))
(ede-cpp-root-project "starrc-proj1"
                      :file (concat my-starrc-src-root "head.proj1/" "Master.hier")
                      :include-path '( "/libSim"
                                       "/xin"
                                       "/dir"
                                       "/dbXtract"
                                       )
                      :system-include-path '( "/usr/include" ))
(ede-cpp-root-project "starrc-proj2"
                      :file (concat my-starrc-src-root "head.proj2/" "Master.hier")
                      :include-path '( "/libSim"
                                       "/xin"
                                       "/dir"
                                       "/dbXtract"
                                       )
                      :system-include-path '( "/usr/include" ))
(ede-cpp-root-project "starrc-proj3"
                      :file (concat my-starrc-src-root "head.proj2/" "Master.hier")
                      :include-path '( "/libSim"
                                       "/xin"
                                       "/dir"
                                       "/dbXtract"
                                       )
                      :system-include-path '( "/usr/include" ))


