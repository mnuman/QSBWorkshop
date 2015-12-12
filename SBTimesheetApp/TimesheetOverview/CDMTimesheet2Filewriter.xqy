xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://TargetNamespace.com/henkiesFileWriter";
(:: import schema at "Resources/henksschema.xsd" ::)
declare namespace ns1="http://xmlns.qualogy.com/cdm/timesheet";
(:: import schema at "../CDM/xsd/timesheet/Timesheet.xsd" ::)

declare variable $TimesheetCollection as element() (:: schema-element(ns1:TimesheetCollection) ::) external;

declare function local:func($TimesheetCollection as element() (:: schema-element(ns1:TimesheetCollection) ::)) as element() (:: schema-element(ns2:Collection) ::) {
    <ns2:Collection>
        {
            for $Timesheet in $TimesheetCollection/ns1:Timesheet
            return 
            
                for $TimeEntry in $Timesheet/ns1:TimeEntry
                return 
                <ns2:Row>
                    <ns2:TimesheetCode>{fn:data($Timesheet/ns1:Id)}</ns2:TimesheetCode>
                    <ns2:EmployeeCode>{fn:data($Timesheet/ns1:Employee)}</ns2:EmployeeCode>
                    <ns2:TimeEntryDate>{fn:data($TimeEntry/ns1:TimeEntryDate)}</ns2:TimeEntryDate>
                    <ns2:Customer>{fn:data($TimeEntry/ns1:Customer)}</ns2:Customer>
                    <ns2:Project>{fn:data($TimeEntry/ns1:Project)}</ns2:Project>
                    <ns2:Task>{fn:data($TimeEntry/ns1:Task)}</ns2:Task>
                    <ns2:Rate>{fn:data($TimeEntry/ns1:Rate)}</ns2:Rate>
                    <ns2:Hours>{fn:data($TimeEntry/ns1:Hours)}</ns2:Hours></ns2:Row>
        }
    </ns2:Collection>
};

local:func($TimesheetCollection)
