class DemoGetDownloadManifestJob < ActiveJob::Base
  queue_as :default

  DEMOS = {
    "193847561DEMO" => {
      manifest_load: 4,
      num_docs: 50,
      max_file_load: 4
    },
    "293847561DEMO" => {
      manifest_load: 4,
      num_docs: 50,
      max_file_load: 8
    },
    "393847561DEMO" => {
      manifest_load: 4,
      num_docs: 100,
      max_file_load: 2,
      error: true
    },
    "493847561DEMO" => {
      manifest_load: 4,
      num_docs: 300,
      max_file_load: 2
    },
    "DEMODEFAULT" => {
      manifest_load: 4,
      num_docs: 10,
      max_file_load: 3
    }
  }.freeze

  def perform(download)
    demo = DEMOS[download.file_number] || DEMOS["DEMODEFAULT"]
    sleep(demo[:manifest_load])
    create_documents(download, demo[:num_docs])

    download.update_attributes!(status: :pending_confirmation)
  end

  def create_documents(download, number)
    number.times do |i|
      download.documents.create(filename: "Sample-VBMS-Document-#{SecureRandom.hex}.pdf", received_at: (i * 2).days.ago)
    end
  end
end
