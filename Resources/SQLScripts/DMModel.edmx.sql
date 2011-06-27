
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, and Azure
-- --------------------------------------------------
-- Date Created: 02/06/2011 16:02:00
-- Generated from EDMX file: D:\Users\doka\Documents\Visual Studio 2010\Projects\DeliveryManager\DeliveryManager\DeliveryManagerModel\DMModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO

IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_ClientOrder]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [FK_ClientOrder];
GO
IF OBJECT_ID(N'[dbo].[FK_DeliveryTypeDelivery]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Deliveries] DROP CONSTRAINT [FK_DeliveryTypeDelivery];
GO
IF OBJECT_ID(N'[dbo].[FK_DepotDepotEntry]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Entries_DepotEntry] DROP CONSTRAINT [FK_DepotDepotEntry];
GO
IF OBJECT_ID(N'[dbo].[FK_OrderOrderEntry]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Entries_OrderEntry] DROP CONSTRAINT [FK_OrderOrderEntry];
GO
IF OBJECT_ID(N'[dbo].[FK_DepotEntryOrderEntry]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Entries_OrderEntry] DROP CONSTRAINT [FK_DepotEntryOrderEntry];
GO
IF OBJECT_ID(N'[dbo].[FK_EntryDeliveryEntity]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Entries] DROP CONSTRAINT [FK_EntryDeliveryEntity];
GO
IF OBJECT_ID(N'[dbo].[FK_OrderDelivery]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [FK_OrderDelivery];
GO
IF OBJECT_ID(N'[dbo].[FK_DeliveryCourier]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Deliveries] DROP CONSTRAINT [FK_DeliveryCourier];
GO
IF OBJECT_ID(N'[dbo].[FK_DepotEntryCorrectionEntry]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Entries_CorrectionEntry] DROP CONSTRAINT [FK_DepotEntryCorrectionEntry];
GO
IF OBJECT_ID(N'[dbo].[FK_CorrectionCorrectionEntry]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Entries_CorrectionEntry] DROP CONSTRAINT [FK_CorrectionCorrectionEntry];
GO
IF OBJECT_ID(N'[dbo].[FK_CorrectionCorrectionType]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Corrections] DROP CONSTRAINT [FK_CorrectionCorrectionType];
GO
IF OBJECT_ID(N'[dbo].[FK_Client_inherits_User]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Users_Client] DROP CONSTRAINT [FK_Client_inherits_User];
GO
IF OBJECT_ID(N'[dbo].[FK_DepotEntry_inherits_Entry]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Entries_DepotEntry] DROP CONSTRAINT [FK_DepotEntry_inherits_Entry];
GO
IF OBJECT_ID(N'[dbo].[FK_OrderEntry_inherits_Entry]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Entries_OrderEntry] DROP CONSTRAINT [FK_OrderEntry_inherits_Entry];
GO
IF OBJECT_ID(N'[dbo].[FK_Courier_inherits_User]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Users_Courier] DROP CONSTRAINT [FK_Courier_inherits_User];
GO
IF OBJECT_ID(N'[dbo].[FK_CorrectionEntry_inherits_Entry]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Entries_CorrectionEntry] DROP CONSTRAINT [FK_CorrectionEntry_inherits_Entry];
GO
IF OBJECT_ID(N'[dbo].[FK_Book_inherits_DeliveryEntity]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DeliveryEntities_Book] DROP CONSTRAINT [FK_Book_inherits_DeliveryEntity];
GO
IF OBJECT_ID(N'[dbo].[FK_CD_inherits_DeliveryEntity]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DeliveryEntities_CD] DROP CONSTRAINT [FK_CD_inherits_DeliveryEntity];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Orders]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Orders];
GO
IF OBJECT_ID(N'[dbo].[Deliveries]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Deliveries];
GO
IF OBJECT_ID(N'[dbo].[DeliveryEntities]', 'U') IS NOT NULL
    DROP TABLE [dbo].[DeliveryEntities];
GO
IF OBJECT_ID(N'[dbo].[Users]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Users];
GO
IF OBJECT_ID(N'[dbo].[DeliveryTypes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[DeliveryTypes];
GO
IF OBJECT_ID(N'[dbo].[Depots]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Depots];
GO
IF OBJECT_ID(N'[dbo].[Entries]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Entries];
GO
IF OBJECT_ID(N'[dbo].[CorrectionTypes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[CorrectionTypes];
GO
IF OBJECT_ID(N'[dbo].[Corrections]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Corrections];
GO
IF OBJECT_ID(N'[dbo].[Users_Client]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Users_Client];
GO
IF OBJECT_ID(N'[dbo].[Entries_DepotEntry]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Entries_DepotEntry];
GO
IF OBJECT_ID(N'[dbo].[Entries_OrderEntry]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Entries_OrderEntry];
GO
IF OBJECT_ID(N'[dbo].[Users_Courier]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Users_Courier];
GO
IF OBJECT_ID(N'[dbo].[Entries_CorrectionEntry]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Entries_CorrectionEntry];
GO
IF OBJECT_ID(N'[dbo].[DeliveryEntities_Book]', 'U') IS NOT NULL
    DROP TABLE [dbo].[DeliveryEntities_Book];
GO
IF OBJECT_ID(N'[dbo].[DeliveryEntities_CD]', 'U') IS NOT NULL
    DROP TABLE [dbo].[DeliveryEntities_CD];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Orders'
CREATE TABLE [dbo].[Orders] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Number] nvarchar(20)  NOT NULL,
    [Date] datetime  NOT NULL,
    [ClientId] int  NOT NULL,
    [DeliveryId] int  NULL,
    [WithoutDelivery] bit  NOT NULL
);
GO

-- Creating table 'Deliveries'
CREATE TABLE [dbo].[Deliveries] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Date] datetime  NOT NULL,
    [Notes] nvarchar(max)  NULL,
    [Status] nvarchar(150)  NOT NULL,
    [Address_Details] nvarchar(max)  NOT NULL,
    [Address_City] nvarchar(300)  NOT NULL,
    [Address_Country] nvarchar(300)  NOT NULL,
    [Address_ZipCode] nvarchar(50)  NULL,
    [DeliveryTypeId] int  NOT NULL,
    [CourierId] int  NULL
);
GO

-- Creating table 'DeliveryEntities'
CREATE TABLE [dbo].[DeliveryEntities] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [Cost] decimal(18,4)  NOT NULL,
    [Price] decimal(18,4)  NOT NULL
);
GO

-- Creating table 'Users'
CREATE TABLE [dbo].[Users] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Phone] nvarchar(50)  NOT NULL,
    [Email] nvarchar(150)  NULL,
    [FullName_Name] nvarchar(300)  NOT NULL,
    [FullName_MiddleName] nvarchar(300)  NULL,
    [FullName_Surname] nvarchar(300)  NULL
);
GO

-- Creating table 'DeliveryTypes'
CREATE TABLE [dbo].[DeliveryTypes] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(250)  NOT NULL,
    [Cost] decimal(18,4)  NOT NULL,
    [IsDefault] bit  NOT NULL
);
GO

-- Creating table 'Depots'
CREATE TABLE [dbo].[Depots] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(150)  NOT NULL,
    [Address_Details] nvarchar(max)  NOT NULL,
    [Address_City] nvarchar(300)  NOT NULL,
    [Address_Country] nvarchar(300)  NOT NULL,
    [Address_ZipCode] nvarchar(50)  NULL
);
GO

-- Creating table 'Entries'
CREATE TABLE [dbo].[Entries] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Count] int  NOT NULL,
    [DeliveryEntityId] int  NOT NULL
);
GO

-- Creating table 'CorrectionTypes'
CREATE TABLE [dbo].[CorrectionTypes] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(250)  NOT NULL,
    [IsNegative] bit  NOT NULL
);
GO

-- Creating table 'Corrections'
CREATE TABLE [dbo].[Corrections] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Date] datetime  NOT NULL,
    [CorrectionTypeId] int  NOT NULL
);
GO

-- Creating table 'Users_Client'
CREATE TABLE [dbo].[Users_Client] (
    [Id] int  NOT NULL
);
GO

-- Creating table 'Entries_DepotEntry'
CREATE TABLE [dbo].[Entries_DepotEntry] (
    [DepotId] int  NOT NULL,
    [Id] int  NOT NULL
);
GO

-- Creating table 'Entries_OrderEntry'
CREATE TABLE [dbo].[Entries_OrderEntry] (
    [OrderId] int  NOT NULL,
    [Cost] decimal(18,4)  NOT NULL,
    [Price] decimal(18,4)  NOT NULL,
    [Id] int  NOT NULL,
    [DepotEntry_Id] int  NOT NULL
);
GO

-- Creating table 'Users_Courier'
CREATE TABLE [dbo].[Users_Courier] (
    [Id] int  NOT NULL
);
GO

-- Creating table 'Entries_CorrectionEntry'
CREATE TABLE [dbo].[Entries_CorrectionEntry] (
    [CorrectionId] int  NOT NULL,
    [Cost] decimal(18,4)  NOT NULL,
    [Id] int  NOT NULL,
    [DepotEntry_Id] int  NOT NULL
);
GO

-- Creating table 'DeliveryEntities_Book'
CREATE TABLE [dbo].[DeliveryEntities_Book] (
    [ISBN] nvarchar(120)  NULL,
    [Id] int  NOT NULL
);
GO

-- Creating table 'DeliveryEntities_CD'
CREATE TABLE [dbo].[DeliveryEntities_CD] (
    [Format] nvarchar(100)  NULL,
    [Id] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'Orders'
ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [PK_Orders]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Deliveries'
ALTER TABLE [dbo].[Deliveries]
ADD CONSTRAINT [PK_Deliveries]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'DeliveryEntities'
ALTER TABLE [dbo].[DeliveryEntities]
ADD CONSTRAINT [PK_DeliveryEntities]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Users'
ALTER TABLE [dbo].[Users]
ADD CONSTRAINT [PK_Users]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'DeliveryTypes'
ALTER TABLE [dbo].[DeliveryTypes]
ADD CONSTRAINT [PK_DeliveryTypes]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Depots'
ALTER TABLE [dbo].[Depots]
ADD CONSTRAINT [PK_Depots]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Entries'
ALTER TABLE [dbo].[Entries]
ADD CONSTRAINT [PK_Entries]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'CorrectionTypes'
ALTER TABLE [dbo].[CorrectionTypes]
ADD CONSTRAINT [PK_CorrectionTypes]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Corrections'
ALTER TABLE [dbo].[Corrections]
ADD CONSTRAINT [PK_Corrections]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Users_Client'
ALTER TABLE [dbo].[Users_Client]
ADD CONSTRAINT [PK_Users_Client]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Entries_DepotEntry'
ALTER TABLE [dbo].[Entries_DepotEntry]
ADD CONSTRAINT [PK_Entries_DepotEntry]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Entries_OrderEntry'
ALTER TABLE [dbo].[Entries_OrderEntry]
ADD CONSTRAINT [PK_Entries_OrderEntry]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Users_Courier'
ALTER TABLE [dbo].[Users_Courier]
ADD CONSTRAINT [PK_Users_Courier]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Entries_CorrectionEntry'
ALTER TABLE [dbo].[Entries_CorrectionEntry]
ADD CONSTRAINT [PK_Entries_CorrectionEntry]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'DeliveryEntities_Book'
ALTER TABLE [dbo].[DeliveryEntities_Book]
ADD CONSTRAINT [PK_DeliveryEntities_Book]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'DeliveryEntities_CD'
ALTER TABLE [dbo].[DeliveryEntities_CD]
ADD CONSTRAINT [PK_DeliveryEntities_CD]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [ClientId] in table 'Orders'
ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [FK_ClientOrder]
    FOREIGN KEY ([ClientId])
    REFERENCES [dbo].[Users_Client]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_ClientOrder'
CREATE INDEX [IX_FK_ClientOrder]
ON [dbo].[Orders]
    ([ClientId]);
GO

-- Creating foreign key on [DeliveryTypeId] in table 'Deliveries'
ALTER TABLE [dbo].[Deliveries]
ADD CONSTRAINT [FK_DeliveryTypeDelivery]
    FOREIGN KEY ([DeliveryTypeId])
    REFERENCES [dbo].[DeliveryTypes]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_DeliveryTypeDelivery'
CREATE INDEX [IX_FK_DeliveryTypeDelivery]
ON [dbo].[Deliveries]
    ([DeliveryTypeId]);
GO

-- Creating foreign key on [DepotId] in table 'Entries_DepotEntry'
ALTER TABLE [dbo].[Entries_DepotEntry]
ADD CONSTRAINT [FK_DepotDepotEntry]
    FOREIGN KEY ([DepotId])
    REFERENCES [dbo].[Depots]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_DepotDepotEntry'
CREATE INDEX [IX_FK_DepotDepotEntry]
ON [dbo].[Entries_DepotEntry]
    ([DepotId]);
GO

-- Creating foreign key on [OrderId] in table 'Entries_OrderEntry'
ALTER TABLE [dbo].[Entries_OrderEntry]
ADD CONSTRAINT [FK_OrderOrderEntry]
    FOREIGN KEY ([OrderId])
    REFERENCES [dbo].[Orders]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_OrderOrderEntry'
CREATE INDEX [IX_FK_OrderOrderEntry]
ON [dbo].[Entries_OrderEntry]
    ([OrderId]);
GO

-- Creating foreign key on [DepotEntry_Id] in table 'Entries_OrderEntry'
ALTER TABLE [dbo].[Entries_OrderEntry]
ADD CONSTRAINT [FK_DepotEntryOrderEntry]
    FOREIGN KEY ([DepotEntry_Id])
    REFERENCES [dbo].[Entries_DepotEntry]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_DepotEntryOrderEntry'
CREATE INDEX [IX_FK_DepotEntryOrderEntry]
ON [dbo].[Entries_OrderEntry]
    ([DepotEntry_Id]);
GO

-- Creating foreign key on [DeliveryEntityId] in table 'Entries'
ALTER TABLE [dbo].[Entries]
ADD CONSTRAINT [FK_EntryDeliveryEntity]
    FOREIGN KEY ([DeliveryEntityId])
    REFERENCES [dbo].[DeliveryEntities]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_EntryDeliveryEntity'
CREATE INDEX [IX_FK_EntryDeliveryEntity]
ON [dbo].[Entries]
    ([DeliveryEntityId]);
GO

-- Creating foreign key on [DeliveryId] in table 'Orders'
ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [FK_OrderDelivery]
    FOREIGN KEY ([DeliveryId])
    REFERENCES [dbo].[Deliveries]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_OrderDelivery'
CREATE INDEX [IX_FK_OrderDelivery]
ON [dbo].[Orders]
    ([DeliveryId]);
GO

-- Creating foreign key on [CourierId] in table 'Deliveries'
ALTER TABLE [dbo].[Deliveries]
ADD CONSTRAINT [FK_DeliveryCourier]
    FOREIGN KEY ([CourierId])
    REFERENCES [dbo].[Users_Courier]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_DeliveryCourier'
CREATE INDEX [IX_FK_DeliveryCourier]
ON [dbo].[Deliveries]
    ([CourierId]);
GO

-- Creating foreign key on [DepotEntry_Id] in table 'Entries_CorrectionEntry'
ALTER TABLE [dbo].[Entries_CorrectionEntry]
ADD CONSTRAINT [FK_DepotEntryCorrectionEntry]
    FOREIGN KEY ([DepotEntry_Id])
    REFERENCES [dbo].[Entries_DepotEntry]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_DepotEntryCorrectionEntry'
CREATE INDEX [IX_FK_DepotEntryCorrectionEntry]
ON [dbo].[Entries_CorrectionEntry]
    ([DepotEntry_Id]);
GO

-- Creating foreign key on [CorrectionId] in table 'Entries_CorrectionEntry'
ALTER TABLE [dbo].[Entries_CorrectionEntry]
ADD CONSTRAINT [FK_CorrectionCorrectionEntry]
    FOREIGN KEY ([CorrectionId])
    REFERENCES [dbo].[Corrections]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_CorrectionCorrectionEntry'
CREATE INDEX [IX_FK_CorrectionCorrectionEntry]
ON [dbo].[Entries_CorrectionEntry]
    ([CorrectionId]);
GO

-- Creating foreign key on [CorrectionTypeId] in table 'Corrections'
ALTER TABLE [dbo].[Corrections]
ADD CONSTRAINT [FK_CorrectionCorrectionType]
    FOREIGN KEY ([CorrectionTypeId])
    REFERENCES [dbo].[CorrectionTypes]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_CorrectionCorrectionType'
CREATE INDEX [IX_FK_CorrectionCorrectionType]
ON [dbo].[Corrections]
    ([CorrectionTypeId]);
GO

-- Creating foreign key on [Id] in table 'Users_Client'
ALTER TABLE [dbo].[Users_Client]
ADD CONSTRAINT [FK_Client_inherits_User]
    FOREIGN KEY ([Id])
    REFERENCES [dbo].[Users]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Id] in table 'Entries_DepotEntry'
ALTER TABLE [dbo].[Entries_DepotEntry]
ADD CONSTRAINT [FK_DepotEntry_inherits_Entry]
    FOREIGN KEY ([Id])
    REFERENCES [dbo].[Entries]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Id] in table 'Entries_OrderEntry'
ALTER TABLE [dbo].[Entries_OrderEntry]
ADD CONSTRAINT [FK_OrderEntry_inherits_Entry]
    FOREIGN KEY ([Id])
    REFERENCES [dbo].[Entries]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Id] in table 'Users_Courier'
ALTER TABLE [dbo].[Users_Courier]
ADD CONSTRAINT [FK_Courier_inherits_User]
    FOREIGN KEY ([Id])
    REFERENCES [dbo].[Users]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Id] in table 'Entries_CorrectionEntry'
ALTER TABLE [dbo].[Entries_CorrectionEntry]
ADD CONSTRAINT [FK_CorrectionEntry_inherits_Entry]
    FOREIGN KEY ([Id])
    REFERENCES [dbo].[Entries]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Id] in table 'DeliveryEntities_Book'
ALTER TABLE [dbo].[DeliveryEntities_Book]
ADD CONSTRAINT [FK_Book_inherits_DeliveryEntity]
    FOREIGN KEY ([Id])
    REFERENCES [dbo].[DeliveryEntities]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Id] in table 'DeliveryEntities_CD'
ALTER TABLE [dbo].[DeliveryEntities_CD]
ADD CONSTRAINT [FK_CD_inherits_DeliveryEntity]
    FOREIGN KEY ([Id])
    REFERENCES [dbo].[DeliveryEntities]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------