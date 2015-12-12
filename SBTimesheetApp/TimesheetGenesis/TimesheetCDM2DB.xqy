xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/top/dbCreateTimesheet";
(:: import schema at "Resources/dbCreateTimesheet_table.xsd" ::)
declare namespace ns1="http://xmlns.qualogy.com/cdm/timesheet";
(:: import schema at "../CDM/xsd/timesheet/Timesheet.xsd" ::)

declare variable $cdmTimesheet as element() (:: schema-element(ns1:Timesheet) ::) external;

declare function local:func($cdmTimesheet as element() (:: schema-element(ns1:Timesheet) ::)) as element() (:: schema-element(ns2:UrenstatenCollection) ::) {
    <ns2:UrenstatenCollection>
        <ns2:Urenstaten>
            <ns2:urenstaatnummer>{fn:data($cdmTimesheet/ns1:Id)}</ns2:urenstaatnummer>
            <ns2:medewerkercode>{fn:data($cdmTimesheet/ns1:Employee)}</ns2:medewerkercode>
            <ns2:urenregelsCollection>
                {
                    for $TimeEntry at $pos in $cdmTimesheet/ns1:TimeEntry
                    return 
                    <ns2:Urenregels>
                        <ns2:regelnummer>{$pos}</ns2:regelnummer>
                        <ns2:regeldatum>{fn:data($TimeEntry/ns1:TimeEntryDate)}</ns2:regeldatum>
                        <ns2:klant>{fn:data($TimeEntry/ns1:Customer)}</ns2:klant>
                        <ns2:projectcode>{fn:data($TimeEntry/ns1:Project)}</ns2:projectcode>
                        <ns2:projecttaak>{fn:data($TimeEntry/ns1:Task)}</ns2:projecttaak>
                        <ns2:tarief>{fn:data($TimeEntry/ns1:Rate)}</ns2:tarief>
                        <ns2:aantalUren>{fn:data($TimeEntry/ns1:Hours)}</ns2:aantalUren></ns2:Urenregels>
                }
            </ns2:urenregelsCollection></ns2:Urenstaten>
    </ns2:UrenstatenCollection>
};

local:func($cdmTimesheet)
