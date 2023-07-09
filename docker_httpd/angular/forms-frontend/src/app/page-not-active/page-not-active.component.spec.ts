import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PageNotActiveComponent } from './page-not-active.component';

describe('PageNotActiveComponent', () => {
  let component: PageNotActiveComponent;
  let fixture: ComponentFixture<PageNotActiveComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [PageNotActiveComponent]
    });
    fixture = TestBed.createComponent(PageNotActiveComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
