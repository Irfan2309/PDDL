(define (domain planetary_terraforming)

    (:requirements
        :strips :typing
    )
    (:types
        mechs
        personnel
        base
        attachment
        region
        seat
    )
    (:predicates
        ;personnel
        (commander ?p)
        (engineer ?p)
        (pilot ?p)
        (sc_officer ?p)
        
        ;objects
        (objects ?obj)
        (mech ?m)
        (manipulating_att ?att)
        (drilling_att ?att)
        (surveying_att ?att)
        (noAttachment ?att)
        (seat ?s)
        (attachMech ?att ?m1)
        
        ;places
        (base ?b)
        (command_center ?b)
        (engineering_bay ?b)
        
        ;terrain 
        (flat ?t)
        (hilly ?t)
        (mountainous ?t)
        
        ;in function - p is in b
        (in ?p ?b)
        
        (inMechSeat ?p ?s ?m)
        
        ;which attachment is connected to the mech 
        (connected ?att ?m)
        
        ;the drilling attachment gets the core sample 
        (drillSample ?drilling_att ?sample)
        
        ;the surveying attachment got the scan 
        (scanSurrounding ?surveying_att ?r)
        
        ;the region is adjacent to the current region
        (adjacent ?r1 ?r2)
        
        (sampleCollection ?m1)
    )
    
    ;--------------------------------------------------------------------------
    
    ;ACTIONS FOR MOVEMENT OF PERSON
    
    ;person leaves the base
    (:action Person_leave
        :parameters
            (?p1 - personnel ?b - base ?r1 - region)
        :precondition
            (and
                (in ?b ?r1)
                (not(in ?p1 ?r1))
                (in ?p1 ?b)
            )
        :effect
            (and
                (in ?p1 ?r1)
                (not(in ?p1 ?b))
            )
    )
    
    ;person arrives at the base
    (:action Person_arrive
        :parameters
            (?p1 - personnel ?b - base ?r1 - region)
        :precondition
            (and
                (in ?b ?r1)
                (not(in ?p1 ?b))
                (in ?p1 ?r1)
            )
        :effect
            (and
                (in ?p1 ?b)
                (not(in ?p1 ?r1))
            )
    )
    
    ;person moves between regions
    (:action Person_Move
        :parameters
            (?p1 - personnel ?r1 - region ?r2 - region)
        :precondition
            (and
                (not(mountainous ?r2))
                (adjacent ?r1 ?r2)
                (in ?p1 ?r1)
            )
        :effect
            (and
                (not(in ?p1 ?r1))
                (in ?p1 ?r2)
            )
    )
    
    ;--------------------------------------------------------------------------
    
    ;ACTIONS FOR GETTING IN AND OUT OF MECH
    
    ;getting in the mech
    (:action Get_in_mech
        :parameters
            (?p1 - personnel ?m - mechs ?b - base)
        :precondition
            (and
                (engineering_bay ?b)
                (in ?p1 ?b)
                (in ?m ?b)
                (not(in ?p1 ?m))
            )
        :effect
            (and
                (in ?p1 ?m)
                (not(in ?p1 ?b))
            )
    )
    
    ;getting in the seat
    (:action Get_in_seat
    :parameters
            (?p1 - personnel ?m1 - mechs ?s1 - seat)
    :precondition
        (and
            (in ?p1 ?m1)
            (in ?s1 ?m1)
            (not(in ?p1 ?s1))
        )
        :effect
            (and
                (in ?p1 ?s1)
                (inMechSeat ?p1 ?s1 ?m1)
            )
    )
    
    ;getting out of the seat
    ; (:action Get_out_seat
    ; :parameters
    ;         (?p1 - personnel ?m1 - mechs ?s1 - seat)
    ; :precondition
    ;     (and
    ;         (in ?s1 ?m1)
    ;         (in ?p1 ?s1)
    ;     )
    ;     :effect
    ;         (and
    ;             (not(in ?p1 ?s1))
    ;             (in ?p1 ?m1)
    ;         )
    ; )
    
    ;getting out of mech 
    
    ;--------------------------------------------------------------------------

    ;ACTIONS FOR MOVEMENT OF PERSON
    
    ;mech leaves the base
    (:action mech_Leave
        :parameters
            (?m1 - mechs ?p1 - personnel ?b - base ?r1 - region ?s1 - seat)
        :precondition
            (and
                
                (in ?m1 ?b)
                (in ?b ?r1)
                (pilot ?p1)
                (not(in ?m1 ?r1))
                (inMechSeat ?p1 ?s1 ?m1)
            )
        :effect
            (and
                (not(in ?m1 ?b))
                (in ?m1 ?r1)
            )
        
    )
    
    ;mech arives at the base
    (:action mech_Arrive
        :parameters
            (?m1 - mechs ?p1 - personnel ?b - base ?r1 - region ?s1 - seat)
        :precondition
            (and
                
                (in ?m1 ?r1)
                (in ?b ?r1)
                (pilot ?p1)
                (not(in ?m1 ?b))
                ; (inMechSeat ?p1 ?s1 ?m1)
            )
        :effect
            (and
                (not(in ?m1 ?r1))
                (in ?m1 ?b)
            )
        
    )

    ;mech moves between regions
    (:action mech_Move
        :parameters
            (?m1 - mechs ?r1 - region ?r2 - region)
        :precondition
            (and
                (in ?m1 ?r1)
                (not(mountainous ?r2))
                (adjacent ?r1 ?r2)
                
            )
        :effect
            (and
                (not(in ?m1 ?r1))
                (in ?m1 ?r2)
            )
        
    )
    
    ;--------------------------------------------------------------------------
     
     ;ADDING AND REMOVING ATTACHMENTS FROM THE MECH
     
    ;adding attachment to mech
    (:action attachinMech
    :parameters
        (?p1 - personnel ?m1 - mechs ?b - base ?att - attachment)
    :precondition
        (and
            (engineering_bay ?b)
            (engineer ?p1)
            (in ?m1 ?b)
            (in ?p1 ?b)
            (noAttachment ?m1)
        )
    :effect
        (and
            (not(noAttachment ?m1))
            (attachMech ?att ?m1)
        )
    )
 
     ;removing attachment from mech
    (:action removeAttachfromMech
    :parameters
        (?p1 - personnel ?m1 - mechs ?b - base ?att - attachment)
    :precondition
        (and
            (engineering_bay ?b)
            (engineer ?p1)
            (in ?m1 ?b)
            (in ?p1 ?b)
            (not(noAttachment ?m1))
            (attachMech ?att ?m1)
        )
    :effect
        (and
            (noAttachment ?m1)
            (not(attachMech ?att ?m1))
        )
    )
    ;--------------------------------------------------------------------------
    
    ; ;Collecting core sample
    ; (:action sampleCollection
    ;     :parameters
    ;         (?p1 - personnel ?p2 - personnel ?m1 - mechs ?r1 - region ?att - attachement ?s1 - seat ?s2 - seat)
    ;     :precondition
    ;         (and
    ;             (mech ?m1)
    ;             (attachMech ?att ?m1)
    ;             (drilling_att ?att)
    ;             (sc_officer ?p1)
    ;             (pilot ?p2)
    ;             (inMechSeat ?p1 ?s1 ?m1)
    ;             (inMechSeat ?p2 ?s2 ?m1)
    ;             (hilly ?r1)
    ;             (not(drillSample ?att))
    ;         )
    ;     :effect
    ;         (and
    ;             (drillSample ?att)
    ;             (sampleCollection ?m1)
    ;         )
    ; )

)


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    