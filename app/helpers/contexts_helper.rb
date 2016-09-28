module ContextsHelper
  def context_categories
    [
      {value: "mainSearchCriteria", name: "Main concept"},
      {value: "administrativeGenderCode", name: "Gender"},
      {value: "ageGroup", name: "Age Group"},
      {value: "taskContext", name: "Task Context"},
      {value: "encounter", name: "Encounter Type"},
      {value: "languageCode", name: "Language"},
      {value: "healthCareProvider", name: "Health Care Provider Type"},
      {value: "severityObservation", name: "Observation Severity"},
      {value: "subTopic", name: "Sub-Topic"},
      {value: "locationOfInterest", name: "Location of Interest (Country)"}
    ]
  end

  def main_criteria_context_values
    [
      {:value => "2.16.840.1.113883.6.103", name: "ICD9‐CM"},
      {:value => "2.16.840.1.113883.6.90", name: "ICD10‐CM"},
      {:value => "2.16.840.1.113883.6.3", name: "ICD10"},
      {:value => "2.16.840.1.113883.6.96", name: "SNOMED‐CT"},
      {:value => "2.16.840.1.113883.6.88", name: "RxNorm"},
      {:value => "2.16.840.1.113883.6.177", name: "MeSH"},
      {:value => "2.16.840.1.113883.6.69", name: "NDC"},
      {:value => "2.16.840.1.113883.6.1", name: "LOINC"}
    ]
  end

  def gender_context_values
    [
      {value: "F", name: "Female"},
      {value: "M", name: "Male"},
      {value: "UN", name: "Undifferentiated"}
    ]
  end

  def age_group_context_values
    [
      {name: "Birth to 1 month (infant, newborn)", value: "D007231"},
      {name: "1 to 23 months (infant)", value: "D007223"},
      {name: "2 to 5 years (child, preschool)", value: "D002675"},
      {name: "6 to 12 years (child)", value: "D002648"},
      {name: "13‐18 years (adolescent)", value: "D000293"},
      {name: "19‐24 years (young adult)", value: "D055815"},
      {name: "19‐44 years (adult)", value: "D000328"},
      {name: "45‐64 years (middle aged)", value: "D008875"},
      {name: "56‐79 years (aged)", value: "D000368"},
      {name: "80 and older (aged)", value: "D000369"}
    ]    
  end

  def task_context_values
    [
      {name: "Order entry", value: "OE"},
      {name: "&nbsp; &nbsp; &nbsp; Laboratory test order entry", value: "LABOE"},
      {name: "&nbsp; &nbsp; &nbsp; Medication order entry", value: "MEDOE"},
      {name: "Patient documentation", value: "PATDOC"},
      {name: "&nbsp; &nbsp; &nbsp; Allergy list review", value: "ALLERLREV"},
      {name: "&nbsp; &nbsp; &nbsp; Clinical note entry", value: "CLINNOTEE"},
      {name: "&nbsp; &nbsp; &nbsp; Diagnosis list entry", value: "DIAGLISTE"},
      {name: "&nbsp; &nbsp; &nbsp; Discharge summary entry", value: "DISCHSUME"},
      {name: "&nbsp; &nbsp; &nbsp; Pathology report entry", value: "PATREPE"},
      {name: "&nbsp; &nbsp; &nbsp; Problem list entry", value: "PROBLISTE"},
      {name: "&nbsp; &nbsp; &nbsp; Radiology report entry", value: "RADREPE"},
      {name: "&nbsp; &nbsp; &nbsp; Immunization list review", value: "IMMLREV"},
      {name: "&nbsp; &nbsp; &nbsp; Reminder list review", value: "REMLREV"},
      {name: "&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Wellness reminder list review", value: "WELLREMLREV"},
      {name: "Patient information review", value: "PATINFO"},
      {name: "&nbsp; &nbsp; &nbsp; Allergy list entry", value: "ALLERLE"},
      {name: "&nbsp; &nbsp; &nbsp; Clinical note review", value: "CLINNOTEREV"},
      {name: "&nbsp; &nbsp; &nbsp; &nbsp; Discharge summary review", value: "DISCHSUMREV"},
      {name: "&nbsp; &nbsp; &nbsp; Diagnosis list review", value: "DIAGLISTREV"},
      {name: "&nbsp; &nbsp; &nbsp; Immunization list entry", value: "IMMLE"},
      {name: "&nbsp; &nbsp; &nbsp; Laboratory results review", value: "LABRREV"},
      {name: "&nbsp; &nbsp; &nbsp; Microbiology results review", value: "MICRORREV"},
      {name: "&nbsp; &nbsp; &nbsp; &nbsp; Microbiology organisms results review", value: "MICROORGRREV"},
      {name: "&nbsp; &nbsp; &nbsp; &nbsp; Microbiology sensitivity test results review", value: "MICROSENSRREV"},
      {name: "&nbsp; &nbsp; &nbsp; Medication list review", value: "MLREV"},
      {name: "&nbsp; &nbsp; &nbsp; &nbsp; Medication administration record work list review", value: "MARWLREV"},
      {name: "&nbsp; &nbsp; &nbsp; Orders review", value: "OREV"},
      {name: "&nbsp; &nbsp; &nbsp; Pathology report review", value: "PATREPREV"},
      {name: "&nbsp; &nbsp; &nbsp; Problem list review", value: "PROBLISTREV"},
      {name: "&nbsp; &nbsp; &nbsp; Radiology report review", value: "RADREPREV"},
      {name: "&nbsp; &nbsp; &nbsp; Reminder list entry", value: "REMLE"},
      {name: "&nbsp; &nbsp; &nbsp; &nbsp; Wellness reminder list entry", value: "WELLREMLE"},
      {name: "&nbsp; &nbsp; &nbsp; Risk assessment instrument", value: "RISKASSESS"},
      {name: "&nbsp; &nbsp; &nbsp; &nbsp; Falls risk assessment instrument", value: "FALLRISK"}
    ]        
  end

  def encounter_context_values
    [
      {name: "Ambulatory", value: "AMB"},
      {name: "Emergency", value: "EMER"},
      {name: "Field", value: "FLD"},
      {name: "Home health", value: "HH"},
      {name: "Inpatient encounter", value: "IMP"},
      {name: "&nbsp; &nbsp; &nbsp; Inpatient acute", value: "ACUTE"},
      {name: "&nbsp; &nbsp; &nbsp; Inpatient non‐acute", value: "NONAC"},
      {name: "Short stay", value: "SS"},
      {name: "Virtual", value: "VR"}
    ]
  end

  def language_code_context_values
    [
      {name: "English", value: "en"},
      {name: "Spanish", value: "es"}
    ]
  end

  def severity_observation_context_values
    [
      {name: "Abnormal", value: "A"},
      {name: "Abnormal alert", value: "AA"},
      {name: "High", value: "H"},
      {name: "High alert", value: "HH"},
      {name: "Low", value: "L"},
      {name: "Low alert", value: "LL"},
      {name: "Normal", value: "N"}
    ]        
  end

  def sub_topic_context_values
    [
      {name: "Administration & dosage", value: "Q000008"},
      {name: "Contraindications", value: "Q000744"},
      {name: "Adverse effects", value: "Q000009"},
      {name: "Drug interaction", value: "D004347"},
      {name: "Classification", value: "Q000145"},
      {name: "Etiology", value: "Q000209"},
      {name: "Diagnosis", value: "Q000175"},
      {name: "Therapy", value: "Q000628"},
      {name: "Prognosis", value: "D011379"},
      {name: "Therapeutic use", value: "Q000627"},
      {name: "Pharmacokinetics", value: "Q000493"},
      {name: "Pharmacology", value: "Q000494"},
      {name: "Toxicity", value: "Q000633"},
      {name: "Poisoning", value: "Q000506"},
      {name: "Drug interaction", value: "79899007"},
      {name: "Differential diagnosis", value: "47965005"},
      {name: "Drug interaction with drug", value: "404204005"},
      {name: "Drug interaction with food", value: "95907004"},
      {name: "Drug interaction with alcohol", value: "95906008"}
    ]        
  end

  def context_item_visibility category, selected_category
    (selected_category == category) ? "" : "display: none"
  end

  def context_value_checked value, selected_values
    selected_values.include?(value) ? true : false
  end
end
