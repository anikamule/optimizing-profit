# Hannah_Benjamin_benja133_1008991307
# Anika_Mule_muleanik_1008850325
reset;

# sets
set I;	# number of shoes types (1 to 557)
set K;	# number of machines (1 to 72)
set N;	# number of raw material (1 to 165)
set L;	# number of warehouses (1 to 8)         

# parameters
param p{I};				# price of shoes type i
param d{I}; 			# demand of shoe i in total
param m{K};				# operation cost of machine k
param c{N}; 			# cost of raw material n
param r{I,N};			# quanity of raw material n required or shoe type i
param a{N}; 			# quantity of raw material available to be puchased in a month
param w{L}; 			# warehouse capacity
param v{I,K};			# average duration on machine k to make shoe type j
var y{i in I} binary;	# binary variable

# decision variables
var x{I} >= 0; 			# number of pairs of shoes of type i

# objective function
maximize profit: (sum{i in I} p[i]*x[i])
				- 10 * (sum{i in I} (d[i] - x[i]) * y[i]) #* y[i]
				- (25/60) * (sum{i in I, k in K} (1/60) * v[i, k] * x[i])
				- (sum{i in I, n in N} x[i] * c[n] * r[i, n])
				- (sum{i in I, k in K} m[k] * (1/60) * v[i, k] * x[i] );
				

# constraints
s.t. RawMaterialsBudget: sum{i in I, n in N} x[i] * c[n] * r[i, n] <= 10000000; # Question 7: change RHS to 17000000
s.t. WarehouseCapacity: sum{i in I} x[i] <= sum{l in L} w[l];
s.t. MachineTime {k in K}: sum {i in I} (1/60) * v[i, k] * x[i] <= 20160; # Question 6: change RHS to 13440
s.t. Demand {i in I}: y[i] = if d[i] - x[i] >= 0 then 1 else 0;
s.t. AvailRawMaterials {n in N}: sum{i in I} x[i] * r[i, n] <= a[n];

