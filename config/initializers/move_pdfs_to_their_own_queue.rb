PdfProductionWorker.class_eval do
  sidekiq_options :queue => :pdf_production
end
