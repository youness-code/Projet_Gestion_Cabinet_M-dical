/*==============================================================*/
/* Nom de SGBD :  ORACLE Version 10gR2                          */
/* Date de création :  03/09/2020 15:03:25                      */
/*==============================================================*/


alter table ORDONNANCE
   drop constraint FK_ORDONNAN_OBTEINT_PATIENT;

alter table ORDONNANCE
   drop constraint FK_ORDONNAN_PRESCRIT_MEDECIN;

alter table RENDEZVOUS
   drop constraint FK_RENDEZVO_EST_AVEC__MEDECIN;

alter table RENDEZVOUS
   drop constraint FK_RENDEZVO_PREND_UN_PATIENT;

alter table RENDEZVOUS
   drop constraint FK_RENDEZVO_RENTRE_UN_SECRETAI;

drop table MEDECIN cascade constraints;

drop index OBTEINT_FK;

drop index PRESCRIT_FK;

drop table ORDONNANCE cascade constraints;

drop table PATIENT cascade constraints;

drop index EST_AVEC_UN_FK;

drop index RENTRE_UN_FK;

drop index PREND_UN_FK;

drop table RENDEZVOUS cascade constraints;

drop table SECRETAIRE cascade constraints;

/*==============================================================*/
/* Table : MEDECIN                                              */
/*==============================================================*/
create table MEDECIN  (
   DRID                 NUMBER(4)                       not null
      constraint CKC_DRID_MEDECIN check (DRID between 1 and 9999),
   DRNOM                VARCHAR2(40)                    not null,
   DRPRENOM             VARCHAR2(40)                    not null,
   DRDNAISS             DATE                            not null,
   constraint PK_MEDECIN primary key (DRID)
);

/*==============================================================*/
/* Table : ORDONNANCE                                           */
/*==============================================================*/
create table ORDONNANCE  (
   ORID                 NUMBER(4)                       not null
      constraint CKC_ORID_ORDONNAN check (ORID between 1 and 9999),
   DRID                 NUMBER(4)                       not null
      constraint CKC_DRID_ORDONNAN check (DRID between 1 and 9999),
   PAID                 NUMBER(4)                       not null
      constraint CKC_PAID_ORDONNAN check (PAID between 1 and 9999),
   ORDATE               DATE                            not null,
   ORDESCRIPT           CLOB                            not null,
   constraint PK_ORDONNANCE primary key (ORID)
);

/*==============================================================*/
/* Index : PRESCRIT_FK                                          */
/*==============================================================*/
create index PRESCRIT_FK on ORDONNANCE (
   DRID ASC
);

/*==============================================================*/
/* Index : OBTEINT_FK                                           */
/*==============================================================*/
create index OBTEINT_FK on ORDONNANCE (
   PAID ASC
);

/*==============================================================*/
/* Table : PATIENT                                              */
/*==============================================================*/
create table PATIENT  (
   PAID                 NUMBER(4)                       not null
      constraint CKC_PAID_PATIENT check (PAID between 1 and 9999),
   PANOM                VARCHAR2(40)                    not null,
   PAPRENOM             VARCHAR2(40)                    not null,
   PADNAISS             DATE                            not null,
   PAADRSS              VARCHAR2(100)                   not null,
   PAVILLE              VARCHAR2(40)                    not null,
   PACODEPOSTAL         VARCHAR2(9)                     not null,
   constraint PK_PATIENT primary key (PAID)
);

/*==============================================================*/
/* Table : RENDEZVOUS                                           */
/*==============================================================*/
create table RENDEZVOUS  (
   RVID                 NUMBER(4)                       not null
      constraint CKC_RVID_RENDEZVO check (RVID between 1 and 9999),
   PAID                 NUMBER(4)                       not null
      constraint CKC_PAID_RENDEZVO check (PAID between 1 and 9999),
   DRID                 NUMBER(4)                       not null
      constraint CKC_DRID_RENDEZVO check (DRID between 1 and 9999),
   SEID                 NUMBER(4)                       not null
      constraint CKC_SEID_RENDEZVO check (SEID between 1 and 9999),
   RVDDEBUT             DATE                            not null,
   RVDFIN               DATE                            not null,
   constraint PK_RENDEZVOUS primary key (RVID)
);

/*==============================================================*/
/* Index : PREND_UN_FK                                          */
/*==============================================================*/
create index PREND_UN_FK on RENDEZVOUS (
   PAID ASC
);

/*==============================================================*/
/* Index : RENTRE_UN_FK                                         */
/*==============================================================*/
create index RENTRE_UN_FK on RENDEZVOUS (
   SEID ASC
);

/*==============================================================*/
/* Index : EST_AVEC_UN_FK                                       */
/*==============================================================*/
create index EST_AVEC_UN_FK on RENDEZVOUS (
   DRID ASC
);

/*==============================================================*/
/* Table : SECRETAIRE                                           */
/*==============================================================*/
create table SECRETAIRE  (
   SEID                 NUMBER(4)                       not null
      constraint CKC_SEID_SECRETAI check (SEID between 1 and 9999),
   SENOM                VARCHAR2(40)                    not null,
   SEPRENOM             VARCHAR2(40)                    not null,
   SEDNAISS             DATE                            not null,
   constraint PK_SECRETAIRE primary key (SEID)
);

alter table ORDONNANCE
   add constraint FK_ORDONNAN_OBTEINT_PATIENT foreign key (PAID)
      references PATIENT (PAID);

alter table ORDONNANCE
   add constraint FK_ORDONNAN_PRESCRIT_MEDECIN foreign key (DRID)
      references MEDECIN (DRID);

alter table RENDEZVOUS
   add constraint FK_RENDEZVO_EST_AVEC__MEDECIN foreign key (DRID)
      references MEDECIN (DRID);

alter table RENDEZVOUS
   add constraint FK_RENDEZVO_PREND_UN_PATIENT foreign key (PAID)
      references PATIENT (PAID);

alter table RENDEZVOUS
   add constraint FK_RENDEZVO_RENTRE_UN_SECRETAI foreign key (SEID)
      references SECRETAIRE (SEID);

