import { PollquestionsRelations } from "./pollquestions-relations";

export interface PollQUestion {
    answer:string,
    pollquestion:string,
    pollquestion_id:number,
    relations:PollquestionsRelations,
    pollquestion_type:string,

}
