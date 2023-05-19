import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { FormQa } from '../form-qa';
import { QaPostComponent } from '../qa-post/qa-post.component';

let li:any;

@Component({
  selector: 'app-post-edit',
  standalone: true,
  imports: [CommonModule, QaPostComponent],
  template: `
    
     <app-qa-post *ngFor="let qpost of FormQa" [qpost] = "qpost"></app-qa-post> <button>SAVE</button>
    
  `,
  styleUrls: ['./post-edit.component.css']
})
export class PostEditComponent {


  FormQa: FormQa [] = []

  constructor(private http:HttpClient, private route: ActivatedRoute){}
    
  id: number = 1
  private sub:any
 
    
    
  ngOnInit(): void {

    this.sub = this.route.params.subscribe(params => 
    this.id = params['forms_id'] )

    this.http.get('http://127.0.0.1:5000/get_form_qa?forms_id=' + this.id).subscribe(Response => {
    console.log(Response)
    li=Response;
    
    console.log(li[0].formtemplates_name)

    for (const i in li){
   console.log(li[i])
   console.log("break")}
    this.FormQa = li
    
    
  })}

 
}