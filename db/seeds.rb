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

DocumentFileType.create(:name => "Logo (PNG)", :category => "Logo", :mime_type => "image/png", :extension => "png")
DocumentFileType.create(:name => "Logo (JPEG)", :category => "Logo", :mime_type => "image/jpeg", :extension => "jpeg")
DocumentFileType.create(:name => "Logo (JPEG)", :category => "Logo", :mime_type => "image/jpeg", :extension => "jpg")
DocumentFileType.create(:name => "Logo (GIF)", :category => "Logo", :mime_type => "image/gif", :extension => "gif")
DocumentFileType.create(:name => "Stylesheet", :category => "Style", :mime_type => "text/css", :extension => "css")


##########################################################################
# DEFINE TEMPLATES
##########################################################################

# Empty template
Document.create(:title => "Empty Document",
  :description => "A basic document to get you started.",
  :is_template => true, :status => published, :visibility => public_vis)

# eMERGE Genomic Resource template
emerge_doc = Document.create(:title => "eMERGE Genomic Resource Template",
  :description => "Developed by the eMERGE network, this template contains sections targeted to genomic resources",
  :institution => "eMERGE",
  :is_template => true, :status => published, :visibility => public_vis)

Section.create(:title => "Clinical scenario/Overview", 
  :description => "- What is it about\r\n- What it is meant to cover (and what topics are excluded)",
  :content => "", :status => published, :visibility => public_vis, :order => 1, :document => emerge_doc)
Section.create(:title => "Background and effects of the condition", :content => "", 
  :description => "- The problems it can cause\r\n- Who it affects\r\n- The symptoms\r\n- How common it is\r\n- How often it occurs in different populations\r\n- An explanation of how the condition runs in a famil\r\n- A description of the difference between being a carrier and having the condition\r\n- A description of the predicted course of the condition\r\n- Details of any complications of the condition",
  :status => published, :visibility => public_vis, :order => 2, :document => emerge_doc)
Section.create(:title => "Treatment and management choices for the condition", 
  :description => "- How the condition is treated\r\n- Any procedure for referral to a specialist\r\n- How symptoms can be reduced\r\n- How well the treatment works\r\n- A description of possible complications of treatment\r\n- Other interventions available e.g. prophylactic surgery, reproductive decision making, medication changes",
  :content => "", :status => published, :visibility => public_vis, :order => 3, :document => emerge_doc)
Section.create(:title => "Risk of developing, carrying or passing on the condition", 
  :description => "- A reason why patient might be at specific risk\r\n- Any implications for having children\r\n- A description of the risk of having the faulty gene compared with the risk of not having the faulty gene\r\n- An explanation of the chance that the condition will not develop\r\n- A comparison of the risk of developing the condition with the risk of getting other diseases or of other events occurring\r\n- An explanation of risk in alternative formats e.g., 1 in 2 or 50%",
  :content => "", :status => published, :visibility => public_vis, :order => 4, :document => emerge_doc)
Section.create(:title => "Types of tests available or being offered",
  :description => "- To confirm a diagnosis where symptoms already exist (diagnostic test)\r\n- To predict whether someone with a family history of a condition will develop the condition (presymptomatic test e.g., Huntington’s disease) or is likely to develop the condition (predictive test e.g., familial breast cancer)\r\n- To check whether someone is a carrier for a recessive disorder (screening test)\r\n- To screen for genetic disorders during pregnancy (i.e., a test of the fetus)\r\n- To screen for genetic disorders in the newborn\r\n- To inform medication management (pharmacogenomics test)",
  :content => "", :status => published, :visibility => public_vis, :order => 5, :document => emerge_doc)
Section.create(:title => "Testing procedure",
  :description => "- How the test is performed\r\n- Where you go to have the test\r\n- If it hurts when you have the test\r\n- The safety/risk of the procedure\r\n- The waiting time for results\r\n- Whether the test is a standard test, part of a research program, and if you have to pay for the test",
  :content => "", :status => published, :visibility => public_vis, :order => 6, :document => emerge_doc)
Section.create(:title => "Test accuracy and reliability",
  :description => "- A description of the meaning of false negative and false positive test results\r\n- Any evidence of local variations in laboratory results\r\n- An explanation if a repeat test may be needed, and why\r\n- An acknowledgment of any limitations of testing",
  :content => "", :status => published, :visibility => public_vis, :order => 7, :document => emerge_doc)
Section.create(:title => "Shared decision making",
  :description => "Suggestions of things to discuss with family, friends, doctors, or other health professionals concerning testing and screening",
  :content => "", :status => published, :visibility => public_vis, :order => 8, :document => emerge_doc)
Section.create(:title => "Potential risks (psychosocial consequences, implications of discrimination, potential risks for others)",
  :description => "- Any emotional consequences\r\n- Any social consequences\r\n- Possible increase in anxiety\r\n- Statement that a range of reactions are possible and normal\r\n- Implications of discrimination arising from the test result, especially on insurance and employment issues\r\n- What being at increased risk might mean to the person being tested and their family\r\n- The emotional consequences for the family\r\n- The implication for relationship e.g., embarrassment, shame, anger, and strained relationships may all be normal outcomes\r\n- Statement that different people have different reactions\r\n- Statement that misattributed paternity may be discovered",
  :content => "", :status => published, :visibility => public_vis, :order => 9, :document => emerge_doc)
Section.create(:title => "Local information",
  :description => "- Any geographical differences in service provision outlined e.g., test availability\r\n- Does it have to be paid for privately or is it free",
  :content => "", :status => published, :visibility => public_vis, :order => 10, :document => emerge_doc)
Section.create(:title => "Additional sources of support and information",
  :description => "e.g., references, websites, other literature, phone numbers, postal addresses, helplines, support groups, other health professionals ",
  :content => "", :status => published, :visibility => public_vis, :order => 11, :document => emerge_doc)
Section.create(:title => "Content contributors",
  :description => "- Original source of content\r\n- Name, degree and institution affiliation of contributors",
  :content => "", :status => published, :visibility => public_vis, :order => 12, :document => emerge_doc)
Section.create(:title => "Date of the information",
  :description => "- Date of publication and any revisions\r\n- An updating policy",
  :content => "", :status => published, :visibility => public_vis, :order => 13, :document => emerge_doc)

# Physician Fact Sheet
fact_sheet = Document.create(:title => "Physician Fact Sheet Template",
  :description => "An abbreviated physician resource that can act as a quick reference",
  :institution => "Northwestern University",
  :is_template => true, :status => published, :visibility => public_vis)

Section.create(:title => "Overview", 
  :content => "Your patient underwent testing for genetic variants associated with [FILL IN HERE]",
  :status => published, :visibility => public_vis, :order => 1, :document => fact_sheet)
Section.create(:title => "Interpretation", 
  :content => "<p>This result predicts that your patient will [FILL IN HERE]</p><p>This means that [FILL IN HERE]</p>",
  :status => published, :visibility => public_vis, :order => 2, :document => fact_sheet)
Section.create(:title => "Recommendation", :content => "",
  :status => published, :visibility => public_vis, :order => 3, :document => fact_sheet)
Section.create(:title => "Limitations", :content => "",
  :status => published, :visibility => public_vis, :order => 4, :document => fact_sheet)
Section.create(:title => "References", :content => "",
  :status => published, :visibility => public_vis, :order => 5, :document => fact_sheet)
Section.create(:title => "Date of the information",
  :content => "", :status => published, :visibility => public_vis, :order => 6, :document => fact_sheet)

Context.create(:item_id => fact_sheet.id, :item_type => 'Document', :category => "informationRecipient",
  :code => "PROV", :code_system_oid => "2.16.840.1.113883.5.110", :code_system_name => "Role Class", :term => "Provider")
