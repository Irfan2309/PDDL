(define (problem movePerson)
    (:domain planetary_terraforming)
    
    (:objects
        commander1 pilot1 engineer1 sc_officer1 pilot2 engineer2 sc_officer2 - personnel
        region1 region2 region3 region4 region5 region6 region7 region8 region9 - region
        cc eng_bay - base
        mech1 mech2 - mechs
        seat1 seat2 - seat
        drill1 survey1 manipulate1 - attachment
        )
    
    (:init
    
        ;adjacency map of the planet
        (adjacent region1 region2)
        (adjacent region1 region4)
        (adjacent region2 region1)
        (adjacent region2 region5)
        (adjacent region2 region3)
        (adjacent region3 region2)
        (adjacent region3 region6)
        (adjacent region4 region1)
        (adjacent region4 region5)
        (adjacent region4 region7)
        (adjacent region5 region2)
        (adjacent region5 region6)
        (adjacent region5 region8)
        (adjacent region5 region4)
        (adjacent region6 region3)
        (adjacent region6 region5)
        (adjacent region6 region9)
        (adjacent region7 region4)
        (adjacent region7 region8)
        (adjacent region8 region7)
        (adjacent region8 region5)
        (adjacent region8 region9)
        (adjacent region9 region8)
        (adjacent region9 region6)
        
        ;terrain of the planet grids
        (flat region1)
        (hilly region2)
        (mountainous region3)
        (flat region4)
        (mountainous region5)
        (hilly region6)
        (flat region7)
        (flat region8)
        (hilly region9)
        
        ;personnel
        (pilot pilot1)
        (engineer engineer1)
        (sc_officer sc_officer1)
        (pilot pilot2)
        (engineer engineer2)
        (sc_officer sc_officer2)
        
        ;base
        (engineering_bay eng_bay)
        (command_center cc)
        
        ;location of the base
        (in cc region1)
        (in eng_bay region8)
        
        ;location of people 
        (in pilot1 cc)
        (in commander1 cc)
        (in engineer1 cc)
        (in sc_officer1 cc)
        
        (in pilot2 cc)
        (in engineer2 cc)
        (in sc_officer2 cc)
        
        ;location of mech 
        (in mech1 eng_bay)
        
        ;attachments
        (drilling_att drill1)
        (surveying_att survey1)
        (manipulating_att manipulate1)
        
        (noAttachment mech1)
        (noAttachment mech2)
        
    )
    
    (:goal
        ;end location
        (in pilot1 region6)
    )
)