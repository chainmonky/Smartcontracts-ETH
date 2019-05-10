pragma solidity ^0.4.24;
contract Certificate{
    address public admin;
    constructor() public{
        admin = msg.sender;
       // certificateDataCount = 0;
    }
     struct CertificateData {
        uint Id;
        address Issuer;
        string InstituteName;
        string IssuerName;
        string CandidateName;
        string CourseName;
        string Location;
        string DateOfCompletion;
    }
    event CertificateEvent(
        string InstituteName,
        string IssuerName,
        string CandidateName,
        string CourseName,
        string Location,
        string DateOfCompletion
    );
    uint public certificateDataCount;
    mapping(address => CertificateData) public issueCertificate;
    function certificateIssue(
        string memory InstituteName,
        string memory IssuerName,
        string memory CandidateName,
        string memory CourseName,
        string memory Location,
        string memory DateOfCompletion) public {
        certificateDataCount += 1;
        issueCertificate[msg.sender] = CertificateData(certificateDataCount, msg.sender, InstituteName,IssuerName,CandidateName,CourseName,Location,DateOfCompletion);
        emit CertificateEvent(InstituteName,IssuerName,CandidateName,CourseName,Location,DateOfCompletion);

        }

}
