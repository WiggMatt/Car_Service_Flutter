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
    '''SELECT cars.carBrand, cars.carModel FROM cars WHERE stsNum = ? ''';

String getWorksDescBySurnameQuery = '''
    SELECT repairDescription FROM mechanics
    INNER JOIN mechanicSpec
    ON mechanics.mechanicId = mechanicSpec.mechanicId
    INNER JOIN repairSpec
    ON mechanicSpec.repairId = repairSpec.repairId
    WHERE lastName = ?''';

String deleteContractQuery = '''DELETE FROM contracts
    WHERE stsNum = ? AND specId = ? ''';

String getSpecIDBySTSAndWorkDescQuery = '''
    SELECT contracts.specId FROM contracts
    INNER JOIN mechanicSpec
    ON contracts.specId = mechanicSpec.specId
    INNER JOIN repairSpec
    ON mechanicSpec.repairId = repairSpec.repairId
    WHERE stsNum = ? AND repairDescription = ? ''';

String editContractQuery = '''UPDATE contracts 
       SET specId = ?, isPaidFor = ?, isCompleted = ? WHERE contractNum = ? ''';

String newSpecIDForEditContractQuery = ''' 
    SELECT specId FROM mechanicSpec
    INNER JOIN mechanics
    ON mechanicSpec.mechanicId = mechanics.mechanicId
    INNER JOIN repairSpec
    ON repairSpec.repairId = mechanicSpec.repairId
    WHERE lastName = ? AND repairDescription = ? ''';

String getContractNumBySTSAndSpecID =
    ''' SELECT contractNum FROM contracts WHERE specId = ? AND stsNum = ? ''';

String loadMechanicsAndWorksTableQuery = ''' 
    SELECT firstName, lastName, repairDescription, coast FROM mechanicSpec
    INNER JOIN repairSpec
    ON mechanicSpec.repairId = repairSpec.repairId
    INNER JOIN mechanics
    ON mechanics.mechanicId = mechanicSpec.mechanicId ''';

String addClientQuery = ''' 
    INSERT INTO clients (firstName, lastName, telephoneNum)
    VALUES (?, ?, ?) ''';

String addCarsQuery = ''' 
    INSERT INTO cars
    VALUES (? ,? ,? ,?) ''';

String deleteClientQuery = ''' 
    DELETE FROM clients
    WHERE clientID = ? ''';

String deleteCarQuery = ''' 
    DELETE FROM cars
    WHERE ownerId = ? AND stsNum = ?''';

String getClientIDByNameQuery = ''' 
    SELECT clientID FROM clients
    WHERE firstName = ? AND lastName = ? ''';

String getClientStsNumQuery = ''' 
    SELECT ownerId FROM cars
    WHERE stsNum = ? ''';

String getOwnerIDQuery = ''' 
    SELECT ownerId FROM cars
    WHERE ownerId = ? ''';

///-----------------------------------------------------------------------------
String addMechanicsQuery = ''' 
    INSERT INTO mechanics (firstName, lastName)
    VALUES (?, ?) ''';

String addMechanicSpecQuery = ''' 
    INSERT INTO mechanicSpec (mechanicId, repairId)
    VALUES (?, ?)''';

String getMechanicIDQuery = ''' 
    SELECT mechanicId FROM mechanics
    WHERE firstName = ? AND lastName = ? ''';

String getRepairIDQuery = ''' 
    SELECT repairId FROM repairSpec
    WHERE repairDescription = ?  ''';

String deleteMechanicQuery = ''' 
    DELETE FROM mechanics
    WHERE mechanicId = ? ''';

String deleteMechanicSpecQuery = ''' 
    DELETE FROM mechanicSpec
    WHERE mechanicId = ? AND repairId = ?''';

String getSpecIDByMechanicID = ''' 
    SELECT specId FROM mechanicSpec
    WHERE mechanicId = ? ''';
