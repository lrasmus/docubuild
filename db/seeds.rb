# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# We want control over statuses, so they are not editable from the application and only through the seeds
# and/or migrations.  We replicate the values for these statuses in the Status model, so any changes here
# should be reflected there as well.
Status.create(:name => "In Progress")
published = Status.create(:name => "Published")
Status.create(:name => "Archived")

public_vis = Visibility.create(:name => "Public")
Visibility.create(:name => "Private")

Document.create(:title => "Empty Document",
  :description => "A basic document to get you started.",
  :is_template => true, :status => published, :visibility => public_vis)

emerge_doc = Document.create(:title => "eMERGE Genomic Resource Template",
  :description => "Developed by the eMERGE network, this template contains sections targeted to genomic resources",
  :institution => "eMERGE",
  :is_template => true, :status => published, :visibility => public_vis)

Section.create(:title => "Clinical scenario/Overview", 
  :description => "<ul><li>What is it about</li><li>What it is meant to cover (and what topics are excluded)</li></ul>",
  :content => "", :status => published, :visibility => public_vis, :order => 1, :document => emerge_doc)
Section.create(:title => "Background and effects of the condition", :content => "", 
  :description => "<ul><li>The problems it can cause</li><li>Who it affects</li><li>The symptoms</li><li>How common it is</li><li>How often it occurs in different populations</li><li>An explanation of how the condition runs in a famil</li><li>A description of the difference between being a carrier and having the condition</li><li>A description of the predicted course of the condition</li><li>Details of any complications of the condition</li></ul>",
  :status => published, :visibility => public_vis, :order => 2, :document => emerge_doc)
Section.create(:title => "Treatment and management choices for the condition", :content => "", :status => published, :visibility => public_vis, :order => 3, :document => emerge_doc)
Section.create(:title => "Risk of developing, carrying or passing on the condition", :content => "", :status => published, :visibility => public_vis, :order => 4, :document => emerge_doc)
Section.create(:title => "Types of tests available or being offered", :content => "", :status => published, :visibility => public_vis, :order => 5, :document => emerge_doc)
Section.create(:title => "Testing procedure", :content => "", :status => published, :visibility => public_vis, :order => 6, :document => emerge_doc)
Section.create(:title => "Test accuracy and reliability", :content => "", :status => published, :visibility => public_vis, :order => 7, :document => emerge_doc)
Section.create(:title => "Shared decision making", :content => "", :status => published, :visibility => public_vis, :order => 8, :document => emerge_doc)
Section.create(:title => "Potential risks (psychosocial consequences, implications of discrimination, potential risks for others)", :content => "", :status => published, :visibility => public_vis, :order => 9, :document => emerge_doc)
Section.create(:title => "Local information", :content => "", :status => published, :visibility => public_vis, :order => 10, :document => emerge_doc)
Section.create(:title => "Additional sources of support and information", :content => "", :status => published, :visibility => public_vis, :order => 11, :document => emerge_doc)
Section.create(:title => "Content contributors", :content => "", :status => published, :visibility => public_vis, :order => 12, :document => emerge_doc)
Section.create(:title => "Date of the information", :content => "", :status => published, :visibility => public_vis, :order => 13, :document => emerge_doc)