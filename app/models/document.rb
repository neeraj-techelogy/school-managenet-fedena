class Document < ActiveRecord::Base
  attr_accessor :attachment_filename
  belongs_to :attachable, :polymorphic=>true

  validates_presence_of :name, :attachable
  validates_length_of :name, :maximum => 250

  has_attached_file :attachment,
    :url => "/system/:class/:attachment/:id/:basename.:extension",
    :path => ":rails_root/public/system/:class/:attachment/:id/:basename.:extension"
  validates_attachment_presence :attachment

  VALID_FILE_TYPES = ['image/png','image/jpeg', 'image/jpg',
    'application/msword', 'application/vnd.ms-office', 'application/vnd.ms-excel', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    'application/pdf',
    'text/plain'
  ]

  validates_attachment_content_type :attachment, :content_type => VALID_FILE_TYPES, :message => ', Only PDF, EXCEL, WORD or TEXT files are allowed.'
  validates_attachment_size :attachment, :less_than => 1.megabyte, :message=>'must be less than 1 MB.'
end
