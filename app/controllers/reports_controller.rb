class ReportsController < ApplicationController
  def index
    @report = Report.paginate(:page => params[:page], :per_page => 5)
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    @request_monthly = Request.all.map{|t| t if t.created_at.strftime("%B") == Time.now.prev_month.strftime("%B")}
    @book = Spreadsheet::Workbook.new
    @sheet = @book.create_worksheet :name => "Report for #{Time.now.prev_month.strftime("%B-%Y")}"
    @sheet.row(1).push "№", "Пользователь", "Тип проблемы", "Комментарий заявителя", "Администратор", "Отчет администратора", "Дата подачи заявки", "Дата закрытия заявки"
    @sheet.row(1).height = 20
    @sheet.row(1).default_format = Spreadsheet::Format.new :weight => :bold
    @sheet.column(1).width = 20
    @sheet.column(2).width = 25
    @sheet.column(3).width = 30
    @sheet.column(4).width = 25
    @sheet.column(5).width = 30
    @sheet.column(6).width = 20
    @sheet.column(7).width = 20
    @i = 2
    @request_monthly.each do |r|
      @sheet.row(@i).push "#{@i - 1}", "#{User.find(r.user_id).name} #{User.find(r.user_id).surname}", r.type_of_problem, r.message, r.admin, r.admin_message, r.created_at.strftime("%d.%m.%Y | %H:%M:%S"), r.updated_at.strftime("%d.%m.%Y | %H:%M:%S")
      @sheet.row(@i).height = 40
      @i += 1
      if r.id == @request_monthly.count - 1
        break
      end
    end
    @report.update_attribute :placement, "./documents/#{Time.now.prev_month.strftime("%B-%Y")}.xls"
    if @report.save and @book.write "./documents/#{Time.now.prev_month.strftime("%B-%Y")}.xls"
      flash[:notice] = 'Отчет успешно сгенерирован'
      redirect_to reports_index_path
    else
      respond_to.html { redirect_to :action => :new, notice: @report.errors }
    end
  end

  private

  def report_params
    params.require(:reports).permit(:month, :year)
  end
end
