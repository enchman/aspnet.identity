CREATE TABLE IF NOT EXISTS `AspNetRoles` (
  `Id` VARCHAR(36) BINARY NOT NULL,
  `Name` VARCHAR(256) NULL,
  `NormalizedName` VARCHAR(256) NULL,
  `ConcurrencyStamp` TEXT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `RoleNameIndex` (`NormalizedName` ASC) VISIBLE
);

CREATE TABLE IF NOT EXISTS `AspNetUsers` (
  `Id` VARCHAR(36) BINARY NOT NULL,
  `UserName` VARCHAR(256) NULL,
  `NormalizedUserName` VARCHAR(256) NOT NULL,
  `Email` VARCHAR(256) NULL,
  `NormalizedEmail` VARCHAR(256) NULL,
  `EmailConfirmed` TINYINT(1) NOT NULL DEFAULT 0,
  `PasswordHash` TEXT NULL,
  `SecurityStamp` LONGTEXT NULL,
  `ConcurrencyStamp` LONGTEXT NULL,
  `PhoneNumber` VARCHAR(1024) NULL,
  `PhoneNumberConfirmed` TINYINT(1) NOT NULL DEFAULT 0,
  `TwoFactorEnabled` TINYINT(1) NOT NULL DEFAULT 0,
  `LockoutEnd` DATETIME NULL,
  `LockoutEnabled` TINYINT(1) NOT NULL DEFAULT 0,
  `AccessFailedCount` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `UserNameIndex` (`NormalizedUserName` ASC) VISIBLE,
  INDEX `EmailIndex` (`NormalizedEmail` ASC) VISIBLE
);

CREATE TABLE IF NOT EXISTS `DeviceCodes` (
  `UserCode` VARCHAR(200) BINARY NOT NULL,
  `DeviceCode` VARCHAR(200) NOT NULL,
  `SubjectId` VARCHAR(200) NULL,
  `SessionId` VARCHAR(100) NULL,
  `ClientId` VARCHAR(200) NOT NULL,
  `Description` VARCHAR(200) NULL,
  `CreationTime` DATETIME NOT NULL,
  `Expiration` DATETIME NOT NULL,
  `Data` TEXT NOT NULL,
  PRIMARY KEY (`UserCode`),
  UNIQUE INDEX `IX_DeviceCodes_DeviceCode` (`DeviceCode` ASC) VISIBLE,
  INDEX `IX_DeviceCodes_Expiration` (`Expiration` ASC) VISIBLE
);

CREATE TABLE IF NOT EXISTS `PersistedGrants` (
  `Key` VARCHAR(200) BINARY NOT NULL,
  `Type` VARCHAR(50) NOT NULL,
  `SubjectId` VARCHAR(200) NULL,
  `SessionId` VARCHAR(100) NULL,
  `ClientId` VARCHAR(200) NOT NULL,
  `Description` VARCHAR(200) NULL,
  `CreationTime` DATETIME NOT NULL,
  `Expiration` DATETIME NULL,
  `ConsumedTime` DATETIME NULL,
  `Data` TEXT NOT NULL,
  PRIMARY KEY (`Key`),
  INDEX `IX_PersistedGrants_Expiration` (`Expiration` ASC) VISIBLE,
  INDEX `IX_PersistedGrants_SubjectId_ClientId_Type` (`SubjectId` ASC, `ClientId` ASC, `Type` ASC) VISIBLE,
  INDEX `IX_PersistedGrants_SubjectId_SessionId_Type` (`SubjectId` ASC, `SessionId` ASC, `Type` ASC) VISIBLE
);

CREATE TABLE IF NOT EXISTS `AspNetRoleClaims` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `RoleId` VARCHAR(36) BINARY NOT NULL,
  `ClaimType` TEXT NULL,
  `ClaimValue` TEXT NULL,
  PRIMARY KEY (`Id`),
  INDEX `IX_AspNetRoleClaims_RoleId` (`RoleId` ASC) VISIBLE,
  CONSTRAINT `FK_AspNetRoleClaims_AspNetRoles_RoleId`
    FOREIGN KEY (`RoleId`)
    REFERENCES `AspNetRoles` (`Id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS `AspNetUserClaims` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `UserId` VARCHAR(36) BINARY NOT NULL,
  `ClaimType` TEXT NULL,
  `ClaimValue` TEXT NULL,
  PRIMARY KEY (`Id`),
  INDEX `IX_AspNetUserClaims_UserId` (`UserId` ASC) VISIBLE,
  CONSTRAINT `FK_AspNetUserClaims_AspNetUsers_UserId`
    FOREIGN KEY (`UserId`)
    REFERENCES `AspNetUsers` (`Id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS `AspNetUserLogins` (
  `LoginProvider` VARCHAR(128) NOT NULL,
  `ProviderKey` VARCHAR(128) BINARY NOT NULL,
  `ProviderDisplayName` TEXT NULL,
  `UserId` VARCHAR(36) BINARY NOT NULL,
  PRIMARY KEY (`LoginProvider`, `ProviderKey`),
  INDEX `IX_AspNetUserLogins_UserId` (`UserId` ASC) VISIBLE,
  CONSTRAINT `FK_AspNetUserLogins_AspNetUsers_UserId`
    FOREIGN KEY (`UserId`)
    REFERENCES `AspNetUsers` (`Id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS `AspNetUserRoles` (
  `UserId` VARCHAR(36) BINARY NOT NULL,
  `RoleId` VARCHAR(36) BINARY NOT NULL,
  PRIMARY KEY (`UserId`, `RoleId`),
  INDEX `IX_AspNetUserRoles_RoleId` (`RoleId` ASC) VISIBLE,
  CONSTRAINT `FK_AspNetUserRoles_AspNetRoles_RoleId`
    FOREIGN KEY (`RoleId`)
    REFERENCES `AspNetRoles` (`Id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_AspNetUserRoles_AspNetUsers_UserId`
    FOREIGN KEY (`UserId`)
    REFERENCES `AspNetUsers` (`Id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS `AspNetUserTokens` (
  `UserId` VARCHAR(36) BINARY NOT NULL,
  `LoginProvider` VARCHAR(128) NOT NULL,
  `Name` VARCHAR(128) NOT NULL,
  `Value` TEXT NULL,
  PRIMARY KEY (`UserId`, `LoginProvider`, `Name`),
  CONSTRAINT `FK_AspNetUserTokens_AspNetUsers_UserId`
    FOREIGN KEY (`UserId`)
    REFERENCES `AspNetUsers` (`Id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
);
