begin;

update monetaryitem_listitem set bwlistitem_id='E25B785763CA45779FBBF2EA93492E25' where bwlistitem_id = '42D76BB2763E413FA23F260BB513A02A';
update  bwlistitem set attributes = attributes || hstore('NameOnCheck','EXP Restaurant and Bar') where id='003D78D2AE4B468888CA32F697597424';
update  bwlistitem set attributes = attributes || hstore('PrintOnCheckName','EXP Restaurant and Bar') where id='C7E6A71757BB4CA4A86FD8BC4B761274';
update monetaryitem_listitem set bwlistitem_id='950E021385414ACF80353057134E5C49' where bwlistitem_id ='F04C2F9805C4469A94E6DB9B7E21D6A3';


create temp table useditems as (select id from bwlistitem where rootou_id='4374E24311D046ADB6F945BCF46114E6' and (id in (select mili.bwlistitem_id from monetaryitem_listitem mili join bwlistitem li on li.id=mili.bwlistitem_id join bwlist l on l.id=li.bwlist_id where l.rootou_id='4374E24311D046ADB6F945BCF46114E6')  or id in ( select mili.taxlistitem_id from monetaryitemtax mili join bwlistitem li on li.id=mili.taxlistitem_id join bwlist l on l.id=li.bwlist_id where l.rootou_id='4374E24311D046ADB6F945BCF46114E6' and l.type='Tax') or id in (select id from bwlistitem where rootou_id='4374E24311D046ADB6F945BCF46114E6' and attributes ? 'Id')));


update bwlistitem set attributes = attributes || hstore('NameOnCheck',attributes->'Name') where bwlist_id='5D507130092F4DF499B1D127569E2A1F' and attributes ? 'ListID' and attributes ? 'NameOnCheck' = false;


create temp table vendor_map as select old.id as oldid, old.attributes->'ListID' as oldextid,new.id as newid,new.attributes->'Id' as newextid,old.attributes->'CompanyName' as name
from bwlistitem old left join bwlistitem new on old.bwlist_id=new.bwlist_id and old.bwlist_id='5D507130092F4DF499B1D127569E2A1F' where
old.attributes->'NameOnCheck' = new.attributes->'PrintOnCheckName' and new.attributes ? 'Id' and old.attributes ? 'ListID' ;

insert into vendor_map values
('6AD9E05BE317410998FD194C2A8529B3','8000019D-1341860839','F7EC89E86A054F408B458B2A6364D4A6',219,'flatworld'),
('2C8B26C4BD294BCE93F7220EA17D6229','80000914-1337278777','095371509F674DEFBC493BF5D1B62D80',166,'beanservices');

-- select old.attributes->'Name',new.attributes->'DisplayName' from vendor_map join bwlistitem old on oldid=old.id join bwlistitem new on newid=new.id order by old.attributes->'Name';


update bwlistitem set attributes = attributes || hstore('Id',newextid) from  vendor_map where attributes->'ListID'=oldextid and bwlistitem.bwlist_id='5D507130092F4DF499B1D127569E2A1F';


------------- GL ------

create temp table gl_map as select old.id as oldid, old.attributes->'ListID' as oldextid,new.id as newid,new.attributes->'Id' as newextid,old.attributes->'AccountNumber' as oldacct, new.attributes->'AcctNum' as newacct from
bwlistitem old left join bwlistitem new on old.bwlist_id=new.bwlist_id and old.bwlist_id='5F2A770873E84F11BD1AAC5A62E64250' where
old.attributes->'AccountNumber' = new.attributes->'AcctNum' and new.attributes ? 'Id' and old.attributes ? 'ListID' ;

update bwlistitem set attributes = attributes || hstore('Id',newextid) from  gl_map where attributes->'ListID'=oldextid and bwlistitem.bwlist_id='5F2A770873E84F11BD1AAC5A62E64250';

------------- Item ------

create temp table item_map as select old.id as oldid, old.attributes->'ListID' as oldextid,new.id as newid,new.attributes->'Id' as newextid,old.attributes->'FullName' as oldacct, new.attributes->'Name' as newacct from
bwlistitem old left join bwlistitem new on old.bwlist_id=new.bwlist_id and old.bwlist_id='BFAE7AFF4BFC4C948A1F0364E1B6F590' where
old.attributes->'Name' = replace(new.attributes->'Name',' (deleted)','') and new.attributes ? 'Id' and old.attributes ? 'ListID' ;

update bwlistitem set attributes = attributes || hstore('Id',newextid) from  item_map where attributes->'ListID'=oldextid and bwlistitem.bwlist_id='BFAE7AFF4BFC4C948A1F0364E1B6F590';


-- class-------

create temp table class_map as select old.id as oldid, old.attributes->'ListID' as oldextid,new.id as newid,new.attributes->'Id' as newextid,old.attributes->'FullName' as oldacct, new.attributes->'Name' as newacct from
bwlistitem old left join bwlistitem new on old.bwlist_id=new.bwlist_id and old.bwlist_id='284FC82F1C4744E18576E2A69A0822E6' where
old.attributes->'Name' = replace(new.attributes->'Name',' (deleted)','') and new.attributes ? 'Id' and old.attributes ? 'ListID' ;

update bwlistitem set attributes = attributes || hstore('Id',newextid) from  class_map where attributes->'ListID'=oldextid and bwlistitem.bwlist_id='284FC82F1C4744E18576E2A69A0822E6';

---- customer ----

update bwlist set name='Customer',type='Customer',externaltype='Customer' where id='BFBD4E15A041406DA5F9CC3429340F52';


create temp table customer_map as select old.id as oldid, old.attributes->'ListID' as oldextid,new.id as newid,new.attributes->'Id' as newextid,old.attributes->'FullName' as oldacct, new.attributes->'FullyQualifiedName' as newacct from
bwlistitem old left join bwlistitem new on old.bwlist_id=new.bwlist_id and old.bwlist_id='BFBD4E15A041406DA5F9CC3429340F52' where
old.attributes->'FullName' = replace(new.attributes->'FullyQualifiedName',' (deleted)','') and new.attributes ? 'Id' and old.attributes ? 'ListID' ;

update bwlistitem set attributes = attributes || hstore('Id',newextid) from  customer_map where attributes->'ListID'=oldextid and bwlistitem.bwlist_id='BFBD4E15A041406DA5F9CC3429340F52';

-- delete all QBO vendors that were added
delete from bwlistitem where bwlist_id in ('5D507130092F4DF499B1D127569E2A1F','5F2A770873E84F11BD1AAC5A62E64250','BFAE7AFF4BFC4C948A1F0364E1B6F590','284FC82F1C4744E18576E2A69A0822E6','BFBD4E15A041406DA5F9CC3429340F52') and attributes ? 'ListID' = false;


delete from bwlistitem_relations where rootou_id = '4374E24311D046ADB6F945BCF46114E6' and ( master_id not in (select id from useditems ));
delete from bwlistitem_relations where rootou_id = '4374E24311D046ADB6F945BCF46114E6' and ( slave_id not in (select id from useditems ));
delete from bwlistitem where rootou_id = '4374E24311D046ADB6F945BCF46114E6' and id not in (select id from useditems );

update bwlist set displaytemplate='{{FullyQualifiedName}}',structtemplate='{"id":"{{Id}}"}' where rootou_id='4374E24311D046ADB6F945BCF46114E6' and type='Item';
update bwlist set displaytemplate='{{AcctNum}}: {{FullyQualifiedName}}',structtemplate='{"id":"{{Id}}"}' where rootou_id='4374E24311D046ADB6F945BCF46114E6' and type='APAccount';
update bwlist set displaytemplate='{{FullyQualifiedName}}',structtemplate='{"id":"{{Id}}"}' where rootou_id='4374E24311D046ADB6F945BCF46114E6' and type='GeneralLedger';
update bwlist set displaytemplate='{{FullyQualifiedName}}',structtemplate='{"id":"{{Id}}"}' where rootou_id='4374E24311D046ADB6F945BCF46114E6' and type='Customer';
update bwlist set displaytemplate='{{DisplayName}}',structtemplate='{"id":"{{Id}}", "name":"{{DisplayName}}", "add1":"{{GivenName}} {{FamilyName}}","add2":"{{BillAddr_Line1}}","add3":"{{BillAddr_City}} {{BillAddr_CountrySubDivisionCode}} {{PostalCode}} {{Country}}","add4":"{{PrimaryPhone_FreeFormNumber}}"}'  where rootou_id='4374E24311D046ADB6F945BCF46114E6' and type='Vendor';
update bwlist set displaytemplate='{{Id}}',structtemplate='{"id":"{{Id}}","amount":"{{Line_Amount}}","date":"{{TxnDate}}","invoiceExtId":"{{Line_LinkedTxn_TxnId}}","vendorId":"{{VendorRef}}","ref":"{{DocNumber}}","type":"{{PayType}}"}' where rootou_id='4374E24311D046ADB6F945BCF46114E6' and type='ImpPayment' and id not in ('15E5FADDD2704C9289CE9D9670A93C87','979D561AD6814C0695741BC73EB21F5E');
update bwlist set displaytemplate='{{Name}}',structtemplate='{"id":"{{Id}}"}' where rootou_id='4374E24311D046ADB6F945BCF46114E6' and type='Class';



commit;
