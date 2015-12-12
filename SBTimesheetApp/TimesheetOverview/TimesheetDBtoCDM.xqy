xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/top/QTimeDB";
(:: import schema at "Resources/QTimeDB_table.xsd" ::)
declare namespace ns2="http://xmlns.qualogy.com/cdm/timesheet";
(:: import schema at "../CDM/xsd/timesheet/Timesheet.xsd" ::)

declare variable $dbCollection as element() (:: schema-element(ns1:UrenstatenCollection) ::) external;

declare function local:transform($dbCollection as element() (:: schema-element(ns1:UrenstatenCollection) ::)) as element() (:: schema-element(ns2:TimesheetCollection) ::) {
    <ns2:TimesheetCollection>
        {
            for $Urenstaten in $dbCollection/ns1:Urenstaten
            return 
            <ns2:Timesheet>
                <ns2:Id>{fn:data($Urenstaten/ns1:urenstaatnummer)}</ns2:Id>
                <ns2:Employee>{fn:data($Urenstaten/ns1:medewerkercode)}</ns2:Employee>
                {
                    for $Urenregels in $Urenstaten/ns1:urenregelsCollection/ns1:Urenregels
                    order by $Urenregels/ns1:regelnummer
                    return 
                    <ns2:TimeEntry>
                        <ns2:TimeEntryDate>{fn:data($Urenregels/ns1:regeldatum)}</ns2:TimeEntryDate>
                        <ns2:Customer>{fn:data($Urenregels/ns1:klant)}</ns2:Customer>
                        { if   (string-length($Urenregels/ns1:projectcode)>0 and string-length($Urenregels/ns1:projecttaak)>0)
                          then (<ns2:Project>{fn:data($Urenregels/ns1:projectcode)}</ns2:Project>,
                                <ns2:Task>{fn:data($Urenregels/ns1:projecttaak)}</ns2:Task>
                                )
                          else ()
                        }
                        <ns2:Rate>{fn:data($Urenregels/ns1:tarief)}</ns2:Rate>
                        <ns2:Hours>{fn:data($Urenregels/ns1:aantalUren)}</ns2:Hours></ns2:TimeEntry>
                }
            </ns2:Timesheet>
        }
    </ns2:TimesheetCollection>
};

local:transform($dbCollection)
