String loadContractTableQuery = '''SELECT contracts.stsNum,
            cars.carBrand, cars.carModel, 
            repairSpec.repairDescription, 
            mechanics.lastName, 
            repairSpec.coast, 
            contracts.isCompleted, 
            contracts.isPaidFor
FROM contracts 
INNER JOIN cars  
ON contracts.stsNum = cars.stsNum
INNER JOIN mechanicSpec
ON contracts.specId = mechanicSpec.specId
INNER JOIN repairSpec
ON mechanicSpec.repairId = repairSpec.repairId
INNER JOIN mechanics
ON mechanicSpec.mechanicId = mechanics.mechanicId
ORDER BY cars.carBrand ''';

String getAllStsQuery = ''' SELECT stsNum FROM cars ''';

String getAllWorksQuery = ''' SELECT repairDescription FROM repairSpec ''';

String getAllWorkersQuery = ''' SELECT lastName FROM mechanics ''';
