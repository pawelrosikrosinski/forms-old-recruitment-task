import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Routes, RouterModule } from '@angular/router';
import { PageNotActiveComponent } from './page-not-active/page-not-active.component';
import { FormListComponent } from './form-list/form-list.component';
import { PostEditComponent } from './post-edit/post-edit.component';

const routes: Routes = [
  {path: '', component: FormListComponent},
  
 // {path: '**', component: PageNotActiveComponent},
  {path: 'add', component: PageNotActiveComponent},
  {path: 'edit/:forms_id', component: PostEditComponent}

];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})

export class AppRoutingModule { }
