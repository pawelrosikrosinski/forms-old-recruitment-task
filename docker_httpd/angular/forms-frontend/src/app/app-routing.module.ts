import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Routes, RouterModule } from '@angular/router';
import { PageNotActiveComponent } from './page-not-active/page-not-active.component';
import { FormListComponent } from './form-list/form-list.component';
import { PostEditComponent } from './post-edit/post-edit.component';
import { AddFormComponent } from './add-form/add-form.component';
import { AddPollComponent } from './add-poll/add-poll.component';

const routes: Routes = [
  {path: '', component: FormListComponent},
  {path: 'edit/:forms_id', component: PostEditComponent},
  {path: 'add', component: AddFormComponent},
  {path: 'poll/:forms_id', component: AddPollComponent},
  {path: '**', component: PageNotActiveComponent}

];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})

export class AppRoutingModule { }
