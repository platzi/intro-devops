import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { Covid19Component } from './covid19.component';

describe('Covid19Component', () => {
  let component: Covid19Component;
  let fixture: ComponentFixture<Covid19Component>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ Covid19Component ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(Covid19Component);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
