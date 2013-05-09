create matrix1={id : '603', title : 'The Matrix', year : '1999-03-31'},
 matrix2={id : '604', title : 'The Matrix Reloaded', year : '2003-05-07'},
 matrix3={id : '605', title : 'The Matrix Revolutions', year : '2003-10-27'},

 neo={name:'Keanu Reeves'},
 morpheus={name:'Laurence Fishburne'},
 trinity={name:'Carrie-Anne Moss'},

 matrix1<-[:ACTS_IN {role : 'Neo'}]-neo,
 matrix2<-[:ACTS_IN {role : 'Neo'}]-neo,
 matrix3<-[:ACTS_IN {role : 'Neo'}]-neo,

 matrix1<-[:ACTS_IN {role : 'Morpheus'}]-morpheus,
 matrix2<-[:ACTS_IN {role : 'Morpheus'}]-morpheus,
 matrix3<-[:ACTS_IN {role : 'Morpheus'}]-morpheus,

 matrix1<-[:ACTS_IN {role : 'Trinity'}]-trinity,
 matrix2<-[:ACTS_IN {role : 'Trinity'}]-trinity,
 matrix3<-[:ACTS_IN {role : 'Trinity'}]-trinity
