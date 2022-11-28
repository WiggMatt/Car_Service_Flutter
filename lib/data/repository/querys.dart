String loadContractTableQuery = '''
            SELECT contracts.stsNum,
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

String loadClientsTableQuery = ''' 
            SELECT cars.carBrand, 
            cars.carModel, 
            cars.stsNum, 
            clients.firstName, 
            clients.lastName, 
            clients.telephoneNum 
            FROM clients
            INNER JOIN cars
            ON cars.ownerId = clients.clientID ''';

String getAllStsQuery = ''' SELECT stsNum FROM cars ''';

String getAllWorksQuery = ''' SELECT repairDescription FROM repairSpec ''';

String getAllWorkersQuery = ''' SELECT lastName FROM mechanics ''';

String addContractQuery =
    '''INSERT INTO contracts (specId, stsNum, isPaidFor, isCompleted)
    SELECT specId, ?, ?, false
    FROM mechanicSpec
    INNER JOIN repairSpec
    ON mechanicSpec.repairId = repairSpec.repairId
    INNER JOIN mechanics
    ON mechanicSpec.mechanicId = mechanics.mechanicId
    WHERE repairDescription = ? AND lastName = ? ''';

String getBrandAndModelOfCarQuery =
    ''' SELECT cars.carBrand, cars.carModel FROM cars WHERE stsNum = ? ''';

String getWorksDescBySurnameQuery = '''
    SELECT repairDescription FROM mechanics
    INNER JOIN mechanicSpec
    ON mechanics.mechanicId = mechanicSpec.mechanicId
    INNER JOIN repairSpec
    ON mechanicSpec.repairId = repairSpec.repairId
    WHERE lastName = ?''';
