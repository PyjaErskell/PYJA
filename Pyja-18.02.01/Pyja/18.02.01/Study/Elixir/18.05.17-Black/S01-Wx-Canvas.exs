#!/usr/bin/env elixir

defmodule WMain do
  @behaviour :wx_object

  @wu_title Path .basename ( Path.rootname __ENV__.file )
  @wu_size { 300, 200 }

  def wm_start_link do
    :wx_object .start_link __MODULE__, [], []
  end

  def init ( _ \\ [] ) do
    mu_wx = :wx .new
    mu_frame = :wxFrame .new mu_wx, -1, @wu_title, size: @wu_size
    :wxTopLevelWindow .centerOnScreen mu_frame
    :wxFrame .connect mu_frame, :size
    :wxFrame .connect mu_frame, :close_window

    mu_panel = :wxPanel .new mu_frame, []
    :wxPanel .connect mu_panel, :paint, [:callback]

    :wxFrame .show mu_frame

    mu_state = %{ panel: mu_panel }
    { mu_frame, mu_state }
  end

  def handle_event { :wx, _, _, _, { :wxSize, :size, x_size, _ } }, x_state = %{ panel: x_panel } do
    :wxPanel .setSize x_panel, x_size
    { :noreply, x_state }
  end

  def handle_event { :wx, _, _, _, { :wxClose, :close_window } }, x_state do
    { :stop, :normal, x_state }
  end

  def handle_sync_event { :wx, _, _, _, { :wxPaint, :paint } }, _, _ = %{ panel: x_panel } do
    nu_brush = :wxBrush .new
    :wxBrush .setColour nu_brush, { 255, 255, 255, 255 }

    nu_dc = :wxPaintDC .new x_panel
    :wxDC .setBackground nu_dc, nu_brush
    :wxDC .clear nu_dc
    :wxPaintDC .destroy nu_dc
    :ok
  end
end

defmodule DMain do
  def dp_it _ do
    { :wx_ref, _, _, pu_pid } = WMain .wm_start_link
    ref = Process .monitor pu_pid
    receive do
      { :DOWN, ^ref, _, _, _ } -> :ok
    end
  end
end

DMain .dp_it System.argv
