import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { ActivatedRoute, Router } from '@angular/router';
import { FormQa } from '../form-qa';
import { QaPostComponent } from '../qa-post/qa-post.component';

let li:any;

@Component({
  selector: 'app-post-edit',
  standalone: true,
  imports: [CommonModule, QaPostComponent],
  template: `
    
     <app-qa-post *ngFor="let qpost of FormQa" [qpost] = "qpost"></app-qa-post> <button (click)="test_variable()">SAVE</button>
    
  `,
  styleUrls: ['./post-edit.component.css'],
  
})
export class PostEditComponent {


  items:string [] = []

  addItem(newItem: string) {
    this.items.push(newItem);
  }


  FormQa: FormQa [] = []

  constructor(private http:HttpClient, private route: ActivatedRoute, private router: Router){}

  save_click(){
    
  }
    
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

  test_variable(){
    console.log(JSON.stringify(this.FormQa))
    const options = {headers: {'Content-Type': 'application/json'}};

    this.http.post('http://127.0.0.1:5000/post_form_qa?forms_id=' + this.id, JSON.stringify(this.FormQa), options).subscribe(Response => {
    console.log(Response)})


    this.router.navigate(['']);



  }

 
}
