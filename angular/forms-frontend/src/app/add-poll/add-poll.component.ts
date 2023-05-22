import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AddPollPostComponent } from '../add-poll-post/add-poll-post.component';
import { PollQUestion } from '../poll-question';
import { HttpClient } from '@angular/common/http';
import { ActivatedRoute, Router } from '@angular/router';

let li:any
let id: number = 1
let sub:any




@Component({
    selector: 'app-add-poll',
    standalone: true,
    templateUrl: './add-poll.component.html',
    styleUrls: ['./add-poll.component.css'],
    imports: [CommonModule, AddPollPostComponent]
})
export class AddPollComponent implements OnInit{


  pollquestion_number: number = 0;
  end: number = 0
  
  constructor(private http: HttpClient, private route: ActivatedRoute, private router: Router) {}

  
 

  sub = this.route.params.subscribe(params => 
  id = params['forms_id'] )



    ngOnInit(): void {
      this.http.get('http://127.0.0.1:5000/get_form_poll?forms_id=' + id).subscribe(Response => {
      console.log(Response)
      li=Response;
      
      console.log(li[0].formtemplates_name)
  
      for (const i in li){
     console.log(li[i])
     console.log("break")
      this.pollquestions = li

      console.log("pollquestion length = " + (this.pollquestions.length))
      
      }
    })}
  

  
      
      determine_next_pollquestion(current_id:number): number{
        let k!:number

        if(current_id == -1){
          return -1
        }

        if (current_id + 1 >= this.pollquestions.length){
          return -1
        }

        if (this.pollquestions[current_id+1].relations == null){
          return current_id + 1
        }

        

        switch (this.pollquestions[current_id+1].relations.if[0]){

          case '=':

          

            for (let j = 0; j < this.pollquestions.length; j++){

              if (this.pollquestions[j].pollquestion_id == this.pollquestions[current_id + 1].relations.pollquestion_id){
                k = j
                break
              }
            }

            console.log("if: " + this.pollquestions[current_id + 1].relations.if.slice(1))
        console.log("answer: " + this.pollquestions[k].answer)
            
            if (this.pollquestions[current_id + 1].relations.if.slice(1) == this.pollquestions[k].answer){
              return current_id + 1
            }
            else {
              return this.determine_next_pollquestion(current_id + 1)
            }
        }


        return -1
      }
      
      
      


    next_pollquestion(){

     

      


      
      console.log("onetwo" + this.pollquestion_number)

      if (this.determine_next_pollquestion(this.pollquestion_number) != -1){
      console.log("yoyo" + this.determine_next_pollquestion(this.pollquestion_number))
      this.pollquestion_number = this.determine_next_pollquestion(this.pollquestion_number)
      
      }


      else {

        
        const options = {headers: {'Content-Type': 'application/json'}};

        this.http.post('http://127.0.0.1:5000/post_form_poll?forms_id=' + id, JSON.stringify(this.pollquestions), options).subscribe(Response => {})
      
        this.router.navigate([''])

      
      }
    }
 

  pollquestions: PollQUestion  []= []
}
