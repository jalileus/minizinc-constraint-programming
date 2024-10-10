/**
Twenty guests are invited to the party and are scheduled to be seated at tables. 
Each table seats no more than five people. At the same time, some guests are in unimportant relationships, 
and such pairs of guests should not sit at the same table.

Simulate these conditions in MiniZinc and find out the minimum number of tables to be used.

Pairs of conflicting guests:
1-6, 1-17, 1-14, 1-9, 1-12, 1-3, 1-5, 1-2, 1-16, 1-7, 2-4, 2-8, 2-14, 2-20, 2-10, 2-9, 2-17, 2-18, 2-15, 2-7, 3-11, 3-10, 3-9, 3-15, 3-18, 3-6, 3-8, 3-12, 4-13, 4-17, 4-9, 4-11, 4-14, 4-15, 4-16, 4-18, 4-8, 5-6, 5-12, 5-8, 5-7, 5-11, 5-15, 5-9, 5-10, 5-14, 5-16, 5-18, 6-7, 6-16, 6-18, 6-19, 6-8, 7-17, 7-14, 7-12, 7-20, 8-15, 8-20, 8-13, 8-18, 8-14, 8-17, 8-16, 8-11, 9-20, 9-11, 9-16, 9-12, 9-10, 9-19, 10-18, 10-11, 10-12, 10-16, 11-16, 11-12, 11-17, 11-20, 11-15, 11-14, 12-19, 12-13, 12-16, 12-18, 12-17, 13-19, 13-15, 14-15, 14-17, 14-20, 15-16, 15-18, 15-20, 16-17, 17-18, 17-19, 17-20, 18-19, 19-20.
**/

int : guests = 20;
array [1..100] of int: first = [1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,4,4,5,5,5,5,5,5,5,5,5,5,5,6,6,6,6,6,7,7,7,7,8,8,8,8,8,8,8,8,9,9,9,9,9,9,10,10,10,10,11,11,11,11,11,11,12,12,12,12,12,13,13,14,14,14,15,15,15,16,17,17,17,18,19];
array [1..100] of int: second =  [6,17,14,9,12,3,5,2,16,7,4,8,14,20,10,9,17,18,15,7,11,10,9,15,18,6,8,12,13,17,9,11,14,15,16,18,8,6,12,8,7,11,15,9,10,14,16,18,7,16,18,19,8,17,14,12,20,15,20,13,18,14,17,16,11,20,11,16,12,10,19,18,11,12,16,16,12,17,20,15,14,19,13,16,18,17,19,15,15,17,20,16,18,20,17,18,19,20,19,20];


array [1..guests] of var 1..guests: AssignedTable;


constraint forall(i in 1..guests)(
  AssignedTable[i] >= 1
);

constraint forall(i in 1..guests)(
    count(j in 1..guests)(AssignedTable[j] == i) <= 5
);

constraint forall(i in 1..100)(
  AssignedTable[first[i]] != AssignedTable[second[i]]
);

var int : table_num = max(AssignedTable);
solve minimize table_num;


output ["min number of tables = \(table_num)\n"];
