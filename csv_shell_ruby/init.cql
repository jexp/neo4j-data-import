begin
start root=node(0) 
   create unique 
   root-[:GENRES]->({type:'GENRES'}), 
   root-[:MOVIES]->({type:'MOVIES'}), 
   root-[:PEOPLE]->({type:'PEOPLE'});
create movie={id : '19995', title : 'Avatar', year : '2009-12-16'};start n=node:node_auto_index(name='Sam Worthington') 
   with count(*) as c 
   where c=0 
   create x={name:'Sam Worthington'}; 
start n=node:node_auto_index(name='Zoe Saldana') 
   with count(*) as c 
   where c=0 
   create x={name:'Zoe Saldana'}; 
start n=node:node_auto_index(name='Sigourney Weaver') 
   with count(*) as c 
   where c=0 
   create x={name:'Sigourney Weaver'}; 
start n=node:node_auto_index(name='Stephen Lang') 
   with count(*) as c 
   where c=0 
   create x={name:'Stephen Lang'}; 
start n=node:node_auto_index(name='Michelle Rodriguez') 
   with count(*) as c 
   where c=0 
   create x={name:'Michelle Rodriguez'}; 
start n=node:node_auto_index(name='Joel Moore') 
   with count(*) as c 
   where c=0 
   create x={name:'Joel Moore'}; 
start n=node:node_auto_index(name='Giovanni Ribisi') 
   with count(*) as c 
   where c=0 
   create x={name:'Giovanni Ribisi'}; 
start n=node:node_auto_index(name='CCH Pounder') 
   with count(*) as c 
   where c=0 
   create x={name:'CCH Pounder'}; 
start n=node:node_auto_index(name='Laz Alonso') 
   with count(*) as c 
   where c=0 
   create x={name:'Laz Alonso'}; 
start n=node:node_auto_index(name='Wes Studi') 
   with count(*) as c 
   where c=0 
   create x={name:'Wes Studi'}; 
start n=node:node_auto_index(name='Dileep Rao') 
   with count(*) as c 
   where c=0 
   create x={name:'Dileep Rao'}; 
start n=node:node_auto_index(name='Matt Gerald') 
   with count(*) as c 
   where c=0 
   create x={name:'Matt Gerald'}; 
start n=node:node_auto_index(name='Dean Knowsley') 
   with count(*) as c 
   where c=0 
   create x={name:'Dean Knowsley'};
start movie=node:node_auto_index(id='19995'),
         actor=node:node_auto_index(name='Sam Worthington')
   movie<-[:ACTS_IN {role : 'Jake Sully'}]-actor; 
start movie=node:node_auto_index(id='19995'),
         actor=node:node_auto_index(name='Zoe Saldana')
   movie<-[:ACTS_IN {role : 'Neytiri'}]-actor; 
start movie=node:node_auto_index(id='19995'),
         actor=node:node_auto_index(name='Sigourney Weaver')
   movie<-[:ACTS_IN {role : 'Dr. Grace Augustine'}]-actor; 
start movie=node:node_auto_index(id='19995'),
         actor=node:node_auto_index(name='Stephen Lang')
   movie<-[:ACTS_IN {role : 'Col. Quaritch'}]-actor; 
start movie=node:node_auto_index(id='19995'),
         actor=node:node_auto_index(name='Michelle Rodriguez')
   movie<-[:ACTS_IN {role : 'Trudy Chacon'}]-actor; 
start movie=node:node_auto_index(id='19995'),
         actor=node:node_auto_index(name='Joel Moore')
   movie<-[:ACTS_IN {role : 'Norm Spellman'}]-actor; 
start movie=node:node_auto_index(id='19995'),
         actor=node:node_auto_index(name='Giovanni Ribisi')
   movie<-[:ACTS_IN {role : 'Selfridge'}]-actor; 
start movie=node:node_auto_index(id='19995'),
         actor=node:node_auto_index(name='CCH Pounder')
   movie<-[:ACTS_IN {role : 'Moha'}]-actor; 
start movie=node:node_auto_index(id='19995'),
         actor=node:node_auto_index(name='Laz Alonso')
   movie<-[:ACTS_IN {role : 'TsuTey'}]-actor; 
start movie=node:node_auto_index(id='19995'),
         actor=node:node_auto_index(name='Wes Studi')
   movie<-[:ACTS_IN {role : 'Eytukan'}]-actor; 
start movie=node:node_auto_index(id='19995'),
         actor=node:node_auto_index(name='Dileep Rao')
   movie<-[:ACTS_IN {role : 'Dr. Max Patel'}]-actor; 
start movie=node:node_auto_index(id='19995'),
         actor=node:node_auto_index(name='Matt Gerald')
   movie<-[:ACTS_IN {role : 'Lyle Wainfleet'}]-actor; 
start movie=node:node_auto_index(id='19995'),
         actor=node:node_auto_index(name='Dean Knowsley')
   movie<-[:ACTS_IN {role : 'Samson Pilot'}]-actor;
commit
